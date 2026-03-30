#!/bin/bash
# Auto-detect XMOM artifact and validate with the correct schema + shared Schematron.

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <xmom-artifact.xml>"
  exit 1
fi

XML="$1"
SCRIPT_DIR="$(dirname "$0")"
SCHEMATRON="$SCRIPT_DIR/xmom-rules.sch"

if ! command -v xmllint >/dev/null 2>&1; then
  echo "Error: xmllint not found. Install it (libxml2-utils) first." >&2
  exit 2
fi

if [ ! -f "$XML" ]; then
  echo "Error: XML file '$XML' not found!" >&2
  exit 3
fi

root_local=$(xmllint --xpath 'local-name(/*)' "$XML" 2>/dev/null)
root_ns=$(xmllint --xpath 'namespace-uri(/*)' "$XML" 2>/dev/null)

if [ -z "$root_local" ] || [ "$root_local" = "" ]; then
  echo "Error: Could not determine root element for '$XML'." >&2
  exit 8
fi

case "$root_local" in
  DataType)
    XSD="$SCRIPT_DIR/XMDM.xsd"
    TYPE_XPATH='string(/*[local-name()="DataType"]/@TypeName)'
    artifact_desc="datatype"
    ;;
  ExceptionStore)
    XSD="$SCRIPT_DIR/MessageStorage1.1.xsd"
    TYPE_XPATH='string(//*[local-name()="ExceptionType"]/@TypeName)'
    artifact_desc="exception"
    ;;
  *)
    echo "Error: Unsupported XMOM artifact root '$root_local' (namespace: $root_ns) in '$XML'." >&2
    exit 9
    ;;
esac

echo "Detected $artifact_desc XML (root='$root_local')."

if [ ! -f "$XSD" ]; then
  echo "Error: XSD file '$XSD' not found!" >&2
  exit 4
fi

FILENAME="$(basename "$XML" .xml)"
if [ -n "$TYPE_XPATH" ]; then
  TYPENAME=$(xmllint --xpath "$TYPE_XPATH" "$XML" 2>/dev/null)
  if [ -n "$TYPENAME" ] && [ "$FILENAME" != "$TYPENAME" ]; then
    echo "Error: XML file name ('$FILENAME') does not match declared name ('$TYPENAME') in XML!" >&2
    exit 10
  fi
fi

echo "Validating $XML against $XSD..."
if xmllint --noout --schema "$XSD" "$XML"; then
  echo "Validation successful: $XML is valid."
else
  echo "Validation failed! See above errors."
  exit 5
fi

if [ -n "$SCHEMATRON" ]; then
  if [ -f "$SCHEMATRON" ]; then
    echo "Validating $XML against Schematron rules in $SCHEMATRON..."
    if xmllint --noout --schematron "$SCHEMATRON" "$XML"; then
      echo "Schematron business rule validation successful."
    else
      echo "Schematron business rule validation failed! See above errors."
      exit 6
    fi
  else
    echo "Warning: Schematron ($SCHEMATRON) not found, skipping business rule checks."
  fi
fi

# Targeted duplicate check between top-level data and service inputs
if xmllint --xpath 'boolean(/*[local-name()="DataType"])' "$XML" >/dev/null 2>&1; then
  duplicate_top_level_service=$(xmllint --xpath 'boolean(/*[local-name()="DataType"]/*[local-name()="Data" and @VariableName = following::*[local-name()="Service"]//*[local-name()="Input"]//*[local-name()="Data"]/@VariableName])' "$XML" 2>/dev/null)
  if [ "$duplicate_top_level_service" = "true" ]; then
    echo "Error: Top-level Data variable names may not clash with service input parameters." >&2
    exit 7
  fi
fi
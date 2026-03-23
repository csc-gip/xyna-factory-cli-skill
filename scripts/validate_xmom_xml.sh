#!/bin/bash
# Validate XMOM XML against Xyna Factory XSD schema
#
# This script validates Xyna XML datatypes or service groups prior to deployment.
# It expects the XSD at: XMDM.xsd alongside this script.
#
# To update or verify the XSD schema, download the latest from:
#   https://github.com/Xyna-Factory/xyna-factory/blob/main/_Interfaces/XMDM.xsd
#
# Example usage (from within scripts directory):
#   ./validate_xmom_xml.sh path/to/yourfile.xml

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <file.xml>"
  exit 1
fi

XML="$1"
SCRIPT_DIR="$(dirname "$0")"
XSD="$SCRIPT_DIR/XMDM.xsd"

if ! command -v xmllint >/dev/null 2>&1; then
  echo "Error: xmllint not found. Install it (libxml2-utils) first." >&2
  exit 2
fi

if [ ! -f "$XML" ]; then
  echo "Error: XML file '$XML' not found!"
  exit 3
fi

if [ ! -f "$XSD" ]; then
  echo "Error: XSD file '$XSD' not found!"
  exit 4
fi

echo "Validating $XML against $XSD..."
if xmllint --noout --schema "$XSD" "$XML"; then
  echo "Validation successful: $XML is valid."
else
  echo "Validation failed! See above errors."
  exit 5
fi

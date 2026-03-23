#!/bin/bash
# Validate Xyna Exception XML against MessageStorage1.1.xsd
#
# This script validates Xyna exception XML files prior to deployment.
# It expects the XSD at: MessageStorage1.1.xsd alongside this script.
#
# To update or verify the XSD schema, download the latest from:
#   https://github.com/Xyna-Factory/xyna-factory/blob/main/xynautils/exceptions/src/MessageStorage1.1.xsd
#
# Example usage (from within scripts directory):
#   ./validate_exception_xml.sh path/to/yourfile.xml

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <exception.xml>"
  exit 1
fi

XML="$1"
SCRIPT_DIR="$(dirname "$0")"
XSD="$SCRIPT_DIR/MessageStorage1.1.xsd"

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

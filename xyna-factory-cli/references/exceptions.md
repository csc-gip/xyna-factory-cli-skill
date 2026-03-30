# Develop and Deploy Xyna Exceptions

## Discovery

Existing exceptions:
```bash
$XYNA listexceptions -workspaceName <workspace name>
```

## Exception Creation

1. Create exception XML

   - Look at [E](../datatype-examples/ExampleXynaException.xml) as an example for a Xyna exception.
   - Look at [Xyna datatypes](./datatypes.md) when you need more information.
   
2. Deploy with CLI

   ```bash
   $XYNA deployexception -fqExceptionName <TypePath.TypeName> -workspaceName <workspace name> -xmlFile <yourfile.xml>
   ```


## Important Notes

- Use PascalCase for ```TypeName``` and a valid Java package name for ```TypePath```
- Use PascalCase for ```ReferenceName``` and a valid Java package name syntax for ```ReferencePath```
- Use CamelCase for variablenames
- Use unique variablenames within an XML


---

### Validating Exception XML

Use the shared validator for all XMOM artifacts ([validate_xmom_xml.sh](../scripts/validate_xmom_xml.sh)):
```bash
../scripts/validate_xmom_xml.sh path/to/yourfile.xml
```

Requires `xmllint` and the schema files (`XMDM.xsd`, `MessageStorage1.1.xsd`) alongside the script.

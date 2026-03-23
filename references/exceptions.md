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

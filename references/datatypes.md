# Develop and Deploy Xyna Datatypes and Service Groups

## Discovery

Existing datatypes or service groups:

```bash
$XYNA listdoms -workspaceName <workspace name>
$XYNA listdoms -applicationName <app name> -versionName <app version>
```

## Datatype Creation

1. Create datatype XML

   Examples: 

   - Use [A](../datatype-examples/ExampleXynaDatatype.xml) and 
         [B](../datatype-examples/AnotherExampleXynaDatatype.xml)
     for basic datatypes with primitive and complex attributes.
   - Use [M](../datatype-examples/ExampleBaseDatatype.xml) for how to add methods.
   - Use [I](../datatype-examples/ExampleSubtype.xml) for how to use inheritance.
   
   A service group is a datatype with no attributes and only static methods e.g. [S](../datatype-examples/ExampleServiceGroup.xml).

2. Deploy with CLI

   ```bash
   $XYNA deploydatatype -fqDatatypeName <TypePath.TypeName> -workspaceName <workspace> -xmlFile <yourfile.xml>
   ```
   
   Example using A:
   ```bash
   $XYNA deploydatatype -fqDatatypeName xyna.example.ExampleXynaDatatype -workspaceName "default workspace" -xmlFile ../datatype-examples/ExampleXynaDatatype.xml
   ```

## Important Notes

 - Use CamelCase for ```TypeName``` and a valid Java package name for ```TypePath```
 - Use ```<TypeName>.xml``` as filename
 - Uee unique variablenames within a XML
 - Datatypes can reference themselfs for recursive datatypes
 - Use the ```ReferenceName``` and ```ReferencePath``` attributes for referencing Xyna datatypes. **Do not use Java types.**
 - Use the ```Type``` tag for String or Java primitive/boxed types only. **Do not use other types.**
 - Always use full Java package names in code snippets
 - Use atleast Java 11 code
 - Use ```java.util.Optional``` to avoid ```null``` checks
 - Use Xyna datatypes as input, output parameters for code snippets
 - Outputs should be a new instance
 - Use service groups over datatype methods
 - Use different datatypes for different states
 - There are no private or protected methods. Use a helper service group for such methods.
 - Attributes are not public, use Getters and Setters

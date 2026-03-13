# Develop and Deploy Xyna Datatypes and Exceptions

Xyna Datatypes, Exceptions and Service Groups are part of the Xyna Meta Object Model XMOM and are stored in XML files within workspaces and applications.
When they are deployed, the XML is used to generate Java code which is then compiled to be run by Xyna Factory.

## Discovery

Existing datatypes:

```bash
$XYNA listdoms -workspaceName <workspace name>
```

Existing exceptions:
```bash
$XYNA listexceptions -workspaceName <workspace name>
```

Find XML of existing objects:
```bash
find $XYNA_DIR/revisions -type f -name <TypeName.xml>
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

## Exception Creation

1. Create exception XML

   - Look at [E](../datatype-examples/ExampleXynaException.xml) as an example for a Xyna exceptions.
   - Look at A and B, if you want to use more complex attributes in the exception message.
   
2. Deploy with CLI

   ```bash
   $XYNA deployexception -fqExceptionName <TypePath.TypeName> -workspaceName <workspace name> -xmlFile <yourfile.xml>
   ```

## Deployment Loop

- If deployment returns an error, fix the XML and redeploy.
- Repeat until the CLI returns no errors.
- Verify the datatype or exception exists

## Troubleshooting

- check the logs for more information in case of deployment errors
- check the generated Java code using the undocumented command

```bash
$XYNA generatecode <fqn of class> [workspace revision|application revision]
```

## Notes

 - Use the Documentatiion tags
 - Use CamelCase for ```TypeName``` and a valid Java package name for ```TypePath```
 - The file name needs to match ```TypeName```
 - variablenames need to be unique within a datatype
 - You can not deploy a datatype with a reference to a not yet existing datatype
 - Datatypes can reference themself for recursive datatypes
 - Always use full Java package names in your Java code
 -  If you use Java code within the datatype check the Java version to use
    ```bas
    $XYNA get xyna.target.mdm.jar.javaversion
    ```

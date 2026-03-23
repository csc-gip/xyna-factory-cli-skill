# Develop and Deploy Xyna Workflows

## Discovery

List existing workflows:

```bash
$XYNA listwfs -workspaceName <workspace name>
$XYNA listwfs -applicationName <app name> -versionName <app version>
```

## Workflow Creation

1. Create workflow XML

   - Start from [ExampleWorkflow.xml](../wf-examples/ExampleWorkflow.xml) as a template.
   - For details on mappings and functions, see [xfl-functions.md](./xfl-functions.md).
   - All workflows are XML files named after their `TypeName`.
   - Type paths must be valid Java package names; Type names use CamelCase.

2. Deploy the workflow:

   ```bash
   $XYNA deploy -fqWorkflowName <TypePath.TypeName> -workspaceName <workspace> -xmlFile <yourfile.xml>
   ```
## Service/Workflow Invocation

- To call a service group or subworkflow, you must define a `<ServiceReference ID="..." ReferenceName="..." ReferencePath="..."/>`.
- **Important service group reference pattern:** When referencing a service group in a workflow XML, Xyna requires the doubled name pattern for `ReferenceName` (for example, `ReferenceName="ServiceGroupForWorkflow.ServiceGroupForWorkflow"` as shown in the ExampleWorkflow.xml).
  - This means you repeat both the service group type name before and after the dot.
  - Not using this pattern will result in referencing errors or unresolved service groups at runtime.
  - Always check the structure in the shipped ExampleWorkflow and other official samples for a direct reference.
- In `<Function>`, use this ID as `ServiceID` and in `<Invoke>`/`<Receive>` tags.
- References (services, datatypes, exceptions) must be deployed before referencing them.

## Mappings and Formula Language

- **Assignment uses `=` (not `:=`) in `<Mapping>`:**
  - Example: `<Mapping>%0%.field="value"</Mapping>`
- **Values must be quoted** for strings and numbers. Use `null` (unquoted) for null assignment.
  - Ex: `%0%.left=null`, `%0%.val="321"`
- **Assignment patterns:**
  1. **Direct assignment:** literal or single variable, e.g. `%1%.field="foo"`, `%2%=%0%`
  2. **Expression/function assignment:** using only the functions in [xfl-functions.md](./xfl-functions.md) or Xyna datatype instance methods, e.g. `%1%.field=concat("a",%0%.field)`, `%2%.val=length(%0%.list)`
  3. **Calculations:** use the Java operations `+, -, *, /` with double-quoted values, e.g. `%1%.value=%0%.value / "1000" + "24" * "60"`. Conversion from/to String is handled automatically.
- **Only use formula functions listed in [xfl-functions.md](./xfl-functions.md).**
- **XML escaping** is required for XML-reserved characters
- **No new or invented functions are allowed.**

## Numbering Scheme in Mappings

- **Numbering is always local to each `<Mappings>` block, 0-based:**
  - `%0%`: first input (if present); if no inputs, first output
  - `%1%`: second input/output, etc.
- Inputs are numbered first, outputs next, in the order they appear in each `<Mappings>` block.
- Double-check the order for every `<Mappings>` section: numberings do _not_ carry over between blocks.

## Workflow Data and Output Linking

- Each `<Data>` or `<Output>` has a unique `ID`, `VariableName`, and `ReferenceName`/`ReferencePath` referencing a deployed datatype.
- Data blocks are wired between steps using `<Source RefID="..."/>` and `<Target RefID="..."/>`.
- Follow the exact pattern in shipped/example workflows for `<Output>` blocks in `<Mappings>`.
- Outputs can only be declared with `<Data>` or `<Exception>`. Never use both at once.

## Validation and Deployment Tips

- Validate XML before deploy using available scripts.
- Fix errors before deploying. See the audit/logs for detailed deploy feedback.
- Every reference (services, datatypes, exceptions) must exist, else deploy will fail.
- After deployment, start a workflow order using:
  ```bash
  $XYNA startorder -orderType <TypePath.TypeName> -workspaceName <workspace>
  ```
- View order/audit with:
  ```bash
  $XYNA showorderdetails -id <orderId> -v
  ```

## Best Practices

- Use `<Documentation>` for XML comments and workflow explanations.
- Always follow the structure of shipped examples—match the order and format of blocks.
- Prefer service groups for reusable logic over datatype methods.
- Use unique variable and block names in every workflow.
- Validate after every change and be rigorous about reference accuracy.

## Further References
- **Formula language and allowed functions:** See [xfl-functions.md](./xfl-functions.md).
- **Example end-to-end workflow:** See [ExampleWorkflow.xml](../wf-examples/ExampleWorkflow.xml).
- **Datatype and service group examples:** See the corresponding references and examples in your documentation.

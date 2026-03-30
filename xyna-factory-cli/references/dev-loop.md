# Xyna Factory Development Loop

## Work with XMOM objects

1. Prepare work

- Use "default workspace" (revision "-1") unless you are given another workspace
- Create the workspace if it does not exist
- Use the workspace of the objects you are changing, do not copy them to the default workspace
- Do not change objects from an application, stop immediatly
- If the workspace status is not OK, stop immediately and report the problem
- Create a temporary working directory e.g. ```XML_DIR=§(mktemp -d)```
- Check the Java version to use
   ```bash
   $XYNA get xyna.target.mdm.jar.javaversion
   ```
- Discover existing XMOM objects you might need, e.g.
  ```bash
     $XYNA listdoms -applicationName Base -versionName 1.1.4 | grep <keyword>
     $XYNA listexceptions -applicationName Base -versionName 1.1.4 | grep <keyword>
     $XYNA listwfs -applicationName Base -versionName 1.1.4 | grep <keyword>
  ```

  Find XML of existing objects:
  ```bash
  find $XYNA_DIR/revisions -type f -name <TypeName.xml>
  ```

2. Work loop

- If you want to change an existing object, locate its XML in its revision directory and copy it to ```$XML_DIR```
- Validate your XML before deployment by running [validate_xmom_xml.sh](../scripts/validate_xmom_xml.sh):
  ```bash
  ../scripts/validate_xmom_xml.sh <yourfile.xml>
  ```
  - If the validation fails:
    - Carefully read the error output from the validation script.
    - Open your XML in an editor and correct the reported structural or typographical errors.
    - Compare with working examples or the provided XSD if needed.
    - Validate again until successful.
  - Only proceed to deployment if your XML is valid.
- Create/Modify the XML in ```$XML_DIR``` and deploy the XMOM object using the apropriate command
  - deploydatatype
  - deployexception or
  - deploy
- If deployment returns an error, fix the XML and redeploy
- Verify the XMOM object exists and is deployed
   ```bash
   $XYNA showdeploymentitemdetails -workspaceName <arg>  -objectName <fqn of xmom object>
   ```
- Repeat until there are no errors

3. Post work

- remove ```$XML_DIR```
- validate the workspace has still status OK, report errors or warnings

## Troubleshooting

- Use ```showdeploymentitemdetails``` with attribute ```-v```
- Check the generated Java code using the undocumented command
   ```bash
   $XYNA generatecode <fqn of xmom object> [workspace revision|application revision]
   ```
- read XML of valid XMOM objects from available Xyna apps to get examples
- last resort: check Xyna logs for more information

## Notes
- Use UTF-8 for all files
- Use propper XML escaping in code snippets, e.g. for <, > when using generics
- Use the ```Documentation``` tags
- XMOM objects are stored below ```$XYNA_DIR/revisions/rev_<revision>/saved/XMOM```
- Deployed XMOM objects are stored below  ```$XYNA_DIR/revisions/rev_<id>/XMOM```
- "default workspace" is located at ```$XYNA_DIR/revisions/rev_workingset```
- Do not change anything in ```$XYNA_DIR/revisions``` or any subdirectory. Only use the deploy commands.
- You can not deploy an XOM object with a reference to a not yet existing object

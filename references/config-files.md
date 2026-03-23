# Inspect Xyna Factory Filesystem Storage

## Runtime Configuration

Xyna stores some runtime and persistence-related configuration data under:

```bash
${XYNA_DIR}/server/storage/
```

You can inspect this directory to understand the stored state of the system.

Example:

```bash
XYNA_DIR_STORAGE=${XYNA_DIR}/server/storage
cd $XYNA_DIR_STORAGE
ls -lah
```

List subdirectories:

```bash
find . -type d
```

Check with ```${XYNA_DIR_STORAGE}/persistence/persistencelayerinstances.xml``` which is the default XML HSITORY persistencelayer instance. This is where most configuration is stored. Defaults to ```defaultHISTORY```.

Example:

```bash
grep -B7 "<isDefault>true</isDefault" persistencelayerinstance.xml | grep -B3 "<connectionType>HISTORY</connectionType>"
    <persistenceLayerInstanceName>xml_2</persistenceLayerInstanceName>
    <persistenceLayerID>3</persistenceLayerID>
    <connectionParameter>defaultHISTORY</connectionParameter>
    <connectionType>HISTORY</connectionType>
```

Check with ```${XYNA_DIR_STORAGE}/persistence/tableconfiguration.xml``` what is stored where.

Example:

```bash
grep -A3 -B2 xynaproperties tableconfiguration.xml
  <tableconfiguration>
    <tableConfigurationID>15</tableConfigurationID>
    <table>xynaproperties</table>
    <persistenceLayerInstanceID>19</persistenceLayerInstanceID>
  </tableconfiguration>
  <tableconfiguration>
    <tableConfigurationID>16</tableConfigurationID>
    <table>xynaproperties</table>
    <persistenceLayerInstanceID>18</persistenceLayerInstanceID>
  </tableconfiguration>
  <tableconfiguration>
```

```tableconfiguration.xml, persistencelayerinstances.xml, persistencelayers.xml, pooldefinition.xml``` are always relevant, as they can not be moved to another storage backend.


## Startup Configuration

Xyna stores its JVM and installation configuration in property files:

1. Find the user xyna is running as
   
   Check the environment:
   
   ```bash
   echo $XYNA_USER
   ```
   
   Check for a running factory:
   
   ```bash
   XYNA_USER=$(ps aux | grep com.gip.xyna.xmcp.xfcli.XynaFactoryCommandLineInterface | grep -v grep | cut -d\  -f1)
   ```
   
2. Get the home directory:

   ```bash
   XYNA_USER_HOME=$(getent passwd $XYNA_USER | cut -d: -f6)
   ```
   
3. Find the property files:
   ```bash
   find /etc/opt/xyna/environment -type f -name "*.properties"
   find $XYNA_USER_HOME/environment -type f -name "*.properties"
   find $HOME/environment -type f -name "*.properties"
   ```
   
   JVM und common options are stored in ```black_edition_001.properties```
   Host specific options are stored in ```<hostname>.properties```
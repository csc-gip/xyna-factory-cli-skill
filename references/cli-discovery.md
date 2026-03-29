# Discover CLI 

Find the installation directory
```bash
grep "installation.folder" /etc/opt/xyna/environment/black_edition_*.properties
grep "installation.folder" $HOME/environment/black_edition_*.properties
```
and check the `server` directory for the CLI script.

Check environment variables:

```bash
env | grep -i xyna
```

Check other locations:

```bash
find /opt -name xynafactory.sh
find /usr/local -name xynafactory.sh
find /local -name xynafactory.sh
find -L $HOME -name xynafactory.sh
```

If you can not find the script, check if Xyna is running by looking for the JVM running it.

```bash
ps aux | grep XynaFactoryCommandLineInterface
```

If there is an open tcp socket on ```localhost:4242```, try [this script](./scripts/xyna_cli.sh).
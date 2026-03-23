---
name: xyna-factory-cli
description: Use this skill to inspect and operate Xyna Factory using the CLI (status, applications, triggers, persistence, configuration).
---

# Xyna Factory CLI

The Xyna Factory CLI is executed via:

```
/opt/xyna/xyna_001/server/xynafactory.sh
```

The script is usually **not in PATH**, so use the full path or define a shortcut.

Recommended:

```bash
XYNA_DIR=/opt/xyna/xyna_001
XYNA=${XYNA_DIR}/server/xynafactory.sh
```

Example:

```bash
$XYNA status
```

If the script cannot be found:

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

If the factory is not running, gather information about the installation (see below) and report to the user.

---

# Command Discovery (Important)

Command options differ per command.  
**Do not assume flags.**

1. List commands:

```bash
$XYNA help | grep '###'
```

2. Search commands:

```bash
$XYNA help | grep '###' | grep <keyword>
```

3. Inspect command options:

```bash
$XYNA help <command>
```

4. Run the command:

```bash
$XYNA <command> <options>
```

Example:

```bash
$XYNA listapplications -t --hideDefinitions
```

---

# System Status

```bash
$XYNA status
$XYNA listsysteminfo
$XYNA listthreadpoolinfo
$XYNA listcapacities
$XYNA listvetos
$XYNA listproperties -v
$XYNA liststatistics
```

---

# Applications & Workspaces

```bash
$XYNA listapplications -t --hideDefinitions
$XYNA listworkspaces -t
```

(`-t` is supported by these commands and formats output as a table.)

---

# Triggers & Filters

```bash
$XYNA listtriggers -s
$XYNA listfilters -c
```

---

# Persistence & Database

```bash
$XYNA listpersistencelayerinstances
$XYNA listconnectionpools -t
$XYNA tableconfig
```

---

# XMOM Storage Mapping

Show datatype → table/column mapping.

All mappings:

```bash
$XYNA listxmomodsnames -c
```

Workspace-specific:

```bash
$XYNA listxmomodsnames -c -workspaceName <workspace>
```

Application-specific:

```bash
$XYNA listxmomodsnames -c \
  -applicationName <application> \
  -versionName <version>
```

---

# Order Troubleshooting

List orders:

```bash
$XYNA listorders
```

Filter orders by status or error:

```bash
$XYNA listorders | grep -i <keyword>
```

Common keywords:

```
xynaexception
running
scheduling
finished
```

List abandoned orders:

```bash
$XYNA listabandonedorders
```

Examples:

```bash
$XYNA listorders | grep -i xynaexception
```

Show information for a specific order:

```bash
$XYNA showorderdetails -id <orderId>
```

Show detailed information for a specific order:

```bash
$XYNA showorderdetails -v -id <orderId>
```

---

# Factory Not Running

If the Xyna Factory is not running, CLI commands will not work.  
Gather information from the filesystem and check the logs. [c.f.](./references/config-files.md)

---

# Log Files and Logging Configuration

Xyna Factory uses **Log4j2** for logging. [c.f.](./references/logging.md)

---

# Development
Xyna Datatypes, Exceptions, Service Groups and Workflows are part of the Xyna Meta Object Model (XMOM). They are stored as XML files within workspaces and applications.
When they are deployed, the XML is used to generate Java code which is then compiled to be run by Xyna Factory.

## Datatypes, Exceptions and Service Groups
See [Datatypes and Service Groups](./references/datatypes.md) for Xyna modelled datatypes and service groups.

See [Exceptions](./references/exceptions.md) for development of Xyna modelled exceptions.

## Workflows (wip)
See [Workflows](./references/workflows.md) for development of Xyna workflows.

## Development Loop
See [Dev Loop](./references/dev-loop.md) for how to develop XMOM objects.
---

# Safe Usage Guidelines

Prefer commands that start with:

- list
- print
- show

Avoid commands that:

- modify configuration
- delete or remove objects
- undeploy objects
- stop or restart components

unless explicitly requested.
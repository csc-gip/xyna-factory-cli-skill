---
name: xyna-factory-cli
description: Use this skill to inspect Xyna Factory using the CLI (status, applications, triggers, persistence, configuration).
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
```

---

# Command Discovery (Important)

Command options differ per command.  
**Do not assume flags.**

1. List commands:

```bash
$XYNA help
```

2. Search commands:

```bash
$XYNA help | grep <keyword>
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
Useful information can still be obtained from the filesystem. [c.f.](./references/xyna-factory-config-files.md)

---

# Log Files and Logging Configuration

Xyna Factory uses **Log4j2** for logging. [c.f.](./references/xyna-factory-logging.md)

---

# Development

## Datatypes, Exceptions and Service Groups
See [Datatype Dev](./references/xyna-factory-datatype-development.md)

## Workflows
tbd

---

# Safe Usage Guidelines

Prefer commands that:

- inspect system status
- list configuration
- show mappings

Avoid commands that:

- modify configuration
- delete objects
- restart components

unless explicitly requested.
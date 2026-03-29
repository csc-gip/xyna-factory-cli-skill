---
name: xyna-factory-cli
description: Use this skill to operate and troubleshoot Xyna Factory through its CLI, covering system status, applications/workspaces, triggers/filters, persistence layers, logging, and runtime configuration, plus XMOM development tasks (datatypes, exceptions, workflows).
---

# Xyna Factory CLI

The Xyna Factory CLI is usually executed via:

```bash
/opt/xyna/xyna_001/server/xynafactory.sh
```

The script is usually **not in PATH**, so use the full path.

Recommended: Set a shortcut

```bash
XYNA_DIR=/opt/xyna/xyna_001
XYNA=${XYNA_DIR}/server/xynafactory.sh
```

Example:

```bash
$XYNA status
```

If the script cannot be found see [CLI discovery](./references/cli-discovery.md)

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

(`-t` output as table, it adds revisions numbers)

List relations of application or workspace

```bash
$XYNA listruntimecontextdependencies -t -workspaceName <workspace>
$XYNA listruntimecontextdependencies -t -applicationName <app> -versionName <version>
```

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

# Directory Structure of Xyna Factory installations

Relative to the installation directory (e.g. `/opt/xyna/xyna_001`), the structure typically looks like this:

```text
/opt/xyna/xyna_001/
├─ backup/                  # Older installation snapshots after updates
├─ server/                  # Contains the CLI script
│  ├─ lib/                  # Global Xyna Java libraries
│  ├─ userlib/              # User-provided global Java libraries (e.g. JDBC drivers)
│  ├─ persistencelayers/    # Available Xyna storage backend libraries
│  └─ storage/              # File-based storage backend data
│     └─ persistence/       # Storage backend configuration (persistencelayers)
├─ revisions/               # datatypes/workflows and Java libraries
│  ├─ rev_workingset/       # The default workspace
│  └─ rev_<number>/         # Runtime contexts by revision number (applications/workspaces)
└─ xmomrepository/          # History for each runtime context
   ├─ runtimecontexts       # File listing all runtime contexts in this directory
   └─ <app or ws rtc>/      # One directory per runtime context
      └─ history            # Log file of runtime context changes
```

Each revision directory (for example `rev_workingset/` or `rev_<number>/`) contains dedicated directories for triggers, filters, services, shared libraries, and XMOM objects.
For workspace runtime contexts, it also contains the working copy under `saved/`.

**DO NOT** change files in or below `revisions/` or `xmomrepository/`; they are managed by Xyna Factory.

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

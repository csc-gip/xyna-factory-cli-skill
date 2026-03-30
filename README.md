# xyna-factory-cli Skill

This repository contains an agent skill that helps an AI agent operate and troubleshoot Xyna Factory through the CLI.

The skill entry file is `SKILL.md`.

## What an agent needs to load this skill

Most skills-compatible agents use this structure:

```text
<skills-root>/
  xyna-factory-cli/
    SKILL.md
    references/
    scripts/
    datatype-examples/
    wf-examples/
```

Important:
- The folder name must match the skill name in `SKILL.md` frontmatter (`name: xyna-factory-cli`).
- Keep all referenced files and folders next to `SKILL.md`.

## Install (local/project agent)

1. Choose your agent's project-level skills folder (for example `.agents/skills/`).
2. Copy this entire repository folder into that skills folder.
3. Ensure the final path is:

```text
.agents/skills/xyna-factory-cli/SKILL.md
```

4. Restart or reload the agent/chat session so it re-indexes skills.

## Install (user/global agent)

1. Choose your agent's user-level skills folder (for example `~/.agents/skills/`).
2. Copy this entire repository folder there.
3. Ensure the final path is:

```text
~/.agents/skills/xyna-factory-cli/SKILL.md
```

4. Restart or reload the agent/chat session.

## Verify installation

Use one of these checks (depends on your agent UI):
- Open the skill picker/menu and confirm `xyna-factory-cli` appears.
- Type `/` in chat and check whether `xyna-factory-cli` is offered as a skill command.
- Ask the agent: "Use xyna-factory-cli to check factory status".

If the skill is not found:
- Confirm folder name equals skill name: `xyna-factory-cli`.
- Confirm `SKILL.md` has valid YAML frontmatter.
- Confirm the agent is pointed to the correct skills directory.
- Reload/restart the agent session.

## Use the skill

Examples:
- "Use xyna-factory-cli and check system status."
- "Use xyna-factory-cli to list applications and workspaces."
- "Use xyna-factory-cli to investigate failed or abandoned orders."

## Notes for this skill

- The skill assumes the Xyna CLI script is available at `/opt/xyna/xyna_001/server/xynafactory.sh` unless configured otherwise.
- Read-only references are under `references/`.
- XML examples for XMOM are in `datatype-examples/` and `wf-examples/`.
- Validation assets are in `scripts/`.

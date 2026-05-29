# AGENTS.md

This file provides guidance to AI coding agents (Claude Code, Cursor, Copilot, etc.) when working with code in this repository.

## Repository Overview

A collection of skills for AI coding agents (Claude, Cursor, Copilot, etc.). Skills are packaged instructions and scripts that extend any AI agent's capabilities.

## Development Workflow

- **Always create and update skills in the `skills/` directory** — this is the source-of-truth for the repository.
- **Use `npx skills add` to install skills into an agent runtime** instead of maintaining a repository-specific copy CLI.
- **Only copy a skill to `.trae/skills/` manually when you need to apply it locally during development.** The `.trae/` directory is the IDE runtime directory for loading skills and is not managed as source code.

## Creating a New Skill

### Directory Structure

```
skills/
  {skill-name}/           # kebab-case directory name
    SKILL.md              # Required: skill definition
    references/           # Optional: detailed reference files for progressive disclosure
      {topic}.md          # Markdown files referenced from SKILL.md
    scripts/              # Optional: only when automation is needed
      {script-name}.sh    # Bash scripts (preferred)
```

### Naming Conventions

- Skill directory: kebab-case (e.g., vercel-deploy, log-monitor)
- SKILL.md: Always uppercase, always this exact filename
- Reference files: kebab-case.md (e.g., budget-guide.md, tile-selection.md)
- Scripts (if needed): kebab-case.sh (e.g., deploy.sh, fetch-logs.sh)

### SKILL.md Format

````markdown
---
name: {skill-name}
description: {One sentence describing when to use this skill. Include trigger phrases like "Deploy my app", "Check logs", etc.}
---

# {Skill Title}

{Brief description of what the skill does.}

## How It Works

{Numbered list explaining the skill's workflow}

## Usage

{Instructions for how to use this skill. For knowledge-based skills, describe how to query. For automation skills, show script usage:}

```bash
bash ./scripts/{script}.sh [args]
```

**Arguments:**

- `arg1` - Description (defaults to X)

**Examples:**
{Show 2-3 common usage patterns}

## Reference

{For complex skills with large amounts of content, split detailed material into separate files under `references/` directory and link them here. The agent will read them on-demand to avoid loading too much context at once.}

- [Topic A](./references/topic-a.md) - When to read this reference
- [Topic B](./references/topic-b.md) - When to read this reference

## Output

{Show example output users will see}

## Present Results to User

{Template for how Claude should format results when presenting to users}

## Troubleshooting

{Common issues and solutions, especially network/permissions errors}
````

### Best Practices for Context Efficiency

Skills are loaded on-demand — only the skill name and description are loaded at startup. The full `SKILL.md` loads into context only when the agent decides the skill is relevant. To minimize context usage:

- **Keep SKILL.md under 500 lines** — put detailed reference material in separate files under `references/`
- **Write specific descriptions** — helps the agent know exactly when to activate the skill
- **Use progressive disclosure** — SKILL.md provides an overview; reference files contain the details. The agent reads reference files only when a specific topic is needed
- **Prefer simplicity** — if a skill is purely knowledge-based, it does not need scripts. Only add scripts when automation is truly required
- **File references work one level deep** — link directly from SKILL.md to reference files

### Using Reference Files

When a skill covers a broad or deep topic (e.g., a knowledge base), split detailed content into `references/` files:

```
skills/
  {skill-name}/
    SKILL.md                      # Overview + links to references
    references/
      topic-a.md                  # Detailed content for topic A
      topic-b.md                  # Detailed content for topic B
```

In SKILL.md, list references with brief descriptions so the agent knows when to read each file:

```markdown
## Reference

- [Topic A](./references/topic-a.md) - Read this when user asks about X
- [Topic B](./references/topic-b.md) - Read this when user asks about Y
```

This way the agent only loads the specific reference it needs, rather than consuming all context at once.

### Script Requirements

Scripts are **optional**. Only add them when the skill requires automation (e.g., deploying, fetching data, running commands). For knowledge-based or advisory skills, SKILL.md and reference files are sufficient.

When scripts are needed:

- Use `#!/bin/bash` shebang
- Use `set -e` for fail-fast behavior
- Write status messages to stderr: `echo "Message" >&2`
- Write machine-readable output (JSON) to stdout
- Include a cleanup trap for temp files
- Reference the script path as `/mnt/skills/user/{skill-name}/scripts/{script}.sh`

### End-User Installation

The quickest way to use skills from this repository:

```bash
npx skills add JxJuly/agent-skills
```

Install a specific skill:

```bash
npx skills add JxJuly/agent-skills --skill git-commit
```

Other manual installation methods:

**Claude Code:**

```
cp -r skills/{skill-name} ~/.claude/skills/
```

**claude.ai:**

Add the skill to project knowledge or paste SKILL.md contents into the conversation.

If the skill requires network access, instruct users to add required domains at claude.ai/settings/capabilities.

# Agent Skills

This repository contains reusable skills for AI coding agents. A skill is a small package of instructions, references, and optional scripts that teaches an agent how to handle a specific workflow.

The repository is intentionally simple: `skills/` is the source of truth, and installation is handled by the `skills` CLI instead of a repository-specific npm package.

## Install

Install all skills from this repository:

```bash
npx skills add JxJuly/agent-skills
```

Install one specific skill:

```bash
npx skills add JxJuly/agent-skills --skill git-commit
```

List available skills before installing:

```bash
npx skills add JxJuly/agent-skills --list
```

Install globally instead of into the current project:

```bash
npx skills add JxJuly/agent-skills --global
```

## Available Skills

- `git-commit` - Analyze git changes, generate a Conventional Commit message, commit safely, and optionally push.
- `package-json-fix` - Analyze and fix `package.json` field order, missing standard fields, and non-standard fields.
- `whistle-use` - Use Whistle Local Agent API to inspect Network/WS traffic and manage Rules, Values, Plugins, HTTPS, certificates, and temp files when users mention whistle or ws2.

## Repository Layout

```text
skills/
  {skill-name}/
    SKILL.md
    references/
    scripts/
```

`SKILL.md` is required. `references/` and `scripts/` are optional and should only be added when a skill needs deeper documentation or automation.

## Create Or Update A Skill

Always edit skills under `skills/`. Use kebab-case for skill directory names, keep the required file named `SKILL.md`, and keep detailed reference material in `references/` when the skill grows large.

Example:

```text
skills/
  deploy-preview/
    SKILL.md
    scripts/
      deploy.sh
```

After updating a skill, reinstall it where needed:

```bash
npx skills add JxJuly/agent-skills --skill deploy-preview
```

## Manual Installation

If an agent does not support `npx skills add`, copy the skill directory into that agent's skill location manually.

For Claude Code:

```bash
cp -r skills/{skill-name} ~/.claude/skills/
```

For agents that support project knowledge, add the relevant `SKILL.md` content and any needed reference files to the project context.

## Development

```bash
npx skills add ./skills/{skill-name} -g -a codex
```
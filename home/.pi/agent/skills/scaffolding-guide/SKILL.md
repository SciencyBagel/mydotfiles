---
name: scaffolding-guide
description: >
  Apply Jahir's scaffolding and tool-setup standards whenever helping with
  project setup, config file creation, boilerplate generation, or tool
  initialization. Trigger on: "create a starting X config", "scaffold a
  project", "set up X", "initialize Y", "show me a template for Z", "how do
  I start a new X project", or any task that produces a config file,
  directory structure, or initial project skeleton. Also trigger when the
  user asks how to set up a tool they haven't used before.
---

# Scaffolding Guide

## Two-Part Response Format

When producing a scaffold, config file, or project skeleton, always structure
the response in two parts:

### Part 1 — The Example

Show the code, config, or file structure directly. Follow the `coding-standards`
skill: document it, annotate flags and options, and note any tradeoffs in the
approach.

### Part 2 — How To Do This Without an LLM

After the example, include a section (if one reasonably exists) covering the
native tooling available for this kind of scaffold. The goal is to teach
Jahir what tools exist so he can reach for them independently.

Format this section clearly, e.g.:

```
## Native Scaffolding Options

Before reaching for an LLM, these tools can generate this for you:

- `ansible-galaxy init <role>` — scaffolds an Ansible role directory structure
- `cookiecutter <template>` — generates projects from community templates
...
```

Cover:
- Official CLI generators or init commands for the tool
- Community scaffold tools (e.g., Cookiecutter templates, language-specific
  generators)
- Any `--init`, `--scaffold`, or `--generate` flags built into the tool itself
- Relevant official docs or starter guides

If no native scaffolding exists for something, say so explicitly — "There's
no built-in generator for this; the LLM approach or a manual template is the
practical path."

## Avoid LLM Dependency

The spirit of this skill is to leave Jahir more capable, not more dependent.
Every scaffold response should increase his ability to do this himself next
time. Err on the side of over-explaining native options rather than under.

## Research Before Advising

For tools that evolve (e.g., Ansible, CLI frameworks, container tooling),
look up current docs before recommending scaffold commands or patterns. Flag
when syntax or conventions may have changed recently.

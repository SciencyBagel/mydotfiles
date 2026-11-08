---
name: coding-standards
description: "Apply Jahir's personal coding standards whenever writing, reviewing, or discussing code of any kind — including scripts, configs, CLI tools, and infrastructure-as-code. Trigger on: \"write me a function\", \"can you code this\", \"review my code\", \"how do I implement X\", \"refactor this\", \"is this a good approach\", or any task that will produce or evaluate code. Also trigger when the user pastes code and asks a question about it. Do NOT skip this skill just because the task seems simple — apply it even for short snippets."
---

# Coding Standards

## Documentation

- Document all code. Every function, module, and non-obvious block of logic
  gets a docstring or inline comment.
- For Python, use docstrings (Google style preferred; be
  consistent within a file).
- For shell/bash, comment intent above non-obvious commands, flags, and
  pipelines — line by line when an example is being taught.
- When explaining a code example, annotate what each command, flag, and
  option does.

## Style and Paradigm

- Prefer **functional programming** by default:
  - Favor pure functions, immutability, and composability.
  - Avoid classes unless the problem clearly benefits from encapsulation,
    shared mutable state, or an established OOP pattern (e.g., a Django
    model, a Textual widget).
  - When reaching for a class, briefly note why it's the right call.
- Follow the idiomatic style for the language in use (PEP 8 for Python, etc.).
- Prefer explicit over implicit. Avoid magic.

## Best Practices

- Write code that is maintainable first, clever second.
- Validate inputs at boundaries. Handle errors explicitly — don't swallow
  exceptions silently.
- Avoid hardcoding values that belong in config or constants.
- Keep functions small and single-purpose.

## Pushback Protocol

This is important: if the user's design or approach has significant tradeoffs
or a clearly better alternative exists, **say so** before or alongside writing
the code they asked for. Don't just implement what was asked if it's subpar.

Format pushback like this:
1. Briefly acknowledge what they asked for.
2. Flag the tradeoff or issue clearly (not buried at the end).
3. Propose the better approach and explain why.
4. Still deliver what they asked for (or the improved version) — don't just
   refuse.

Pushback triggers include: inefficient algorithms when input scale matters,
unnecessary mutability, class-where-function-suffices, poor separation of
concerns, patterns that hurt testability, and anything that will be painful
to maintain.
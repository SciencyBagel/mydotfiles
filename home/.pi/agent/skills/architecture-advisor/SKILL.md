---
name: architecture-advisor
description: >
  Apply Jahir's architecture and design standards whenever discussing system
  design, project structure, technology choices, or high-level approaches.
  Trigger on: "how should I structure this", "is this a good design", "what's
  the best way to architect X", "should I use X or Y", "review my design",
  "what are the tradeoffs", or any task where the user is making a structural
  or technology decision. Also trigger when a coding task involves non-trivial
  design choices — don't limit this to pure design conversations.
---

# Architecture Advisor

## Research First

Before advising on tools, frameworks, or patterns — especially ones that
evolve quickly — look up current documentation or release notes. Don't rely
solely on training data for best practices. A quick doc skim is worth it.
Call out when your advice is based on looked-up current docs vs. general
knowledge.

## Prioritize Maintainability

- Recommend approaches that a future reader (including Jahir six months from
  now) can understand and modify without deep context.
- Prefer boring, well-understood solutions over clever or novel ones unless
  there's a concrete reason to reach for something new.
- Favor explicit configuration over convention-heavy magic.

## Surface Tradeoffs Proactively

Don't wait to be asked "what are the tradeoffs." If a design decision has
meaningful tradeoffs, surface them upfront:
- What does this approach optimize for?
- What does it sacrifice?
- At what scale or complexity does this break down?
- Is there a simpler alternative that covers 90% of the use case?

## Pushback Protocol

If the proposed design has a better alternative, say so clearly — don't bury
it. Format:
1. Acknowledge the approach.
2. Name the tradeoff or problem specifically.
3. Propose the alternative and explain the concrete benefit.
4. Help them move forward with whichever direction they choose.

Common pushback triggers: over-engineering for the current scale, unnecessary
abstraction layers, coupling that hurts testability, choosing a heavy
framework when a lightweight one suffices, and patterns that conflict with
the functional-first preference (see `coding-standards` skill).

## Consistency With Coding Standards

Architecture advice should be consistent with the `coding-standards` skill:
- Prefer functional decomposition over class hierarchies where reasonable.
- Keep module boundaries clean and single-purpose.
- Flag when a design choice will force unnecessary OOP.

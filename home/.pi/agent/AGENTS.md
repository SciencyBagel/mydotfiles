# Global Preferences

- Keep responses very short by default. Lead with the answer or blocker, include only essential next steps, and expand only when I ask. Say explicitly when more information is needed.
- Summarize changes briefly.
- When starting a project or doing some work for me, feel free to ask clarifying questions to better understand my intent.
- When creating or materially updating substantial Markdown files, include and maintain a table of contents near the top.
- Create and maintain `AI-README.md` for README-style documentation you author, in the directory where a `README.md` would go. Leave `README.md` for me to create and maintain, except for obvious corrections or information too useful to omit.
- When giving command options, explain what each of the options do.

## General Coding

- Prefer direct dependencies over speculative abstractions. In internal refactors, update callers instead of adding compatibility aliases or forwarding wrappers unless a documented compatibility requirement justifies them.
- After making or suggesting changes on a git repo, include one concise Conventional Commits-style sample commit message that covers all tracked but uncommitted changes. Do not include Co-authored-by trailers or other co-author attribution.
- Keep complexity reasonable. Coding agents tend to overcomplicate things.
- When updating repo documentation, do not put information that easily becomes outdated. It should be information that is more stable.
- The readme should primarily have simple overview, usage, installation, table of contents, key features.

## Coding Style

- Name things explicitly. `serversPingedSinceLastCheck` over `pinged`, `candidate` over `a`. A name should say what the value means, not what happened to it.
- Declare a variable where its value is decided, not earlier. Prefer

      Address newPrimary;
      if (...) { newPrimary = x; } else { newPrimary = y; }

  over initializing to a placeholder or to the old value and patching it later. The structure of the code should mirror the structure of the decision being made, so each block decides one thing.
- No ternary operators. Use if/else.
- Prefer early returns over wrapping a method body in a conditional. Do any cleanup that must always happen (resetting state, re-arming a timer) before the guard so the early return doesn't skip it.
- Derive values with a small method instead of storing a second copy in a field, unless there's a reason to cache. Two copies of the same truth have to be kept in sync on every path.
- Add a docstring to functions explaining what they do. Inline comments explain why a line exists, not what it does. Keep them in the voice of the surrounding code.

## Python

- Use `uv` for python projects including the build backend unless I specify otherwise.

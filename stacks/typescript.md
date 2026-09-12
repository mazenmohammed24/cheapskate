# TypeScript — Known AI-Agent Failure Modes

Cross-cutting patterns an agent commonly gets wrong in TypeScript code, on top of the core Cheapskate rules.

- **Silencing instead of fixing.** `as any` or `// @ts-ignore` to make a type error disappear is the single most common way an AI "fixes" a type error while removing the exact check that was correctly catching a bug.
- **Widening instead of narrowing.** Changing a specific union or literal type to `string`/`unknown` to make an error go away, instead of handling the actual case the type system flagged.
- **Assuming `tsconfig.json` settings from memory.** `strict`, null checks, and implicit-any behavior vary a lot project to project — check the actual config rather than assuming a default.
- **Breaking `verbatimModuleSyntax`/`isolatedModules` builds** by not distinguishing type-only imports (`import type`) from value imports when the project has that flag on — the failure looks unrelated to the edit that caused it.

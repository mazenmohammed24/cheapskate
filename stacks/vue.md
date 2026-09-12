# Vue — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Vue code, on top of the core Cheapskate rules.

- **Destructuring breaks reactivity.** `const { count } = reactive(obj)` silently loses tracking — use `toRefs`/`toRef`, or keep the reactive object intact and access properties through it.
- **Mixing Options API and Composition API idioms** in the same component instead of matching whatever the codebase has already standardized on.
- **`v-model` version confusion.** Vue 2's single `v-model` and `.sync` modifier are not Vue 3's API — Vue 3 uses multiple named `v-model` bindings and drops `.sync` entirely. Check the version before assuming either.
- **Mutating a prop directly.** Vue warns at runtime, but the line reads as correct and is an easy mistake to write in the first place — emit an event or use a local copy instead.

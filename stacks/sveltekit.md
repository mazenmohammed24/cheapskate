# Svelte / SvelteKit — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Svelte/SvelteKit code, on top of the core Cheapskate rules.

- **Svelte 4 vs Svelte 5 reactivity.** Svelte 5's runes (`$state`, `$derived`, `$effect`) replace the old `$:` reactive statement and `export let` props — mixing the two idioms in the same file breaks in ways that aren't always caught until runtime. Check the version before assuming which model applies.
- **Server-only code leaking to the client.** `+page.server.ts`/`+layout.server.ts` run server-only (safe for secrets); the plain `+page.ts`/`+layout.ts` variants run universally, including in the browser bundle. Putting server-only logic in the wrong file ships it to the client.
- **Store auto-subscription only works at component top level.** `$store` syntax inside a callback or nested function doesn't get the automatic subscribe/unsubscribe — needs an explicit `.subscribe()` with manual teardown there instead.

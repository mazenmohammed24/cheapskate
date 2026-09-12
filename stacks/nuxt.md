# Nuxt — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Nuxt code, on top of the core Cheapskate rules.

- **Nuxt 2 vs Nuxt 3 confusion.** Nuxt 2 is Vue 2 with `asyncData`/`fetch` options; Nuxt 3 is Vue 3 on the Nitro server engine with `useFetch`/`useAsyncData` composables. Check `package.json`/`nuxt.config` before assuming either convention.
- **Fighting auto-imports.** Components and composables are auto-imported by convention — adding explicit `import` statements reflexively can be unnecessary or even conflict with what Nuxt already resolves.
- **Server routes vs page-level fetching.** Assuming logic belongs in `server/api/` when the project's existing pattern does data-fetching at the page/component level, or vice versa — match the existing split rather than introducing a second one.

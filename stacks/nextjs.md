# Next.js — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Next.js code, on top of the core Cheapskate rules.

- **App Router vs Pages Router confusion.** Training data spans both eras. Check for an `app/` vs `pages/` directory before assuming which data-fetching model (`getServerSideProps` vs Server Components + `fetch`), routing convention, or layout system applies.
- **Missing or wrong `"use client"` boundary.** Server Components can't use hooks, browser APIs, or event handlers — adding `useState` to a file without `"use client"` fails at build/runtime, and the fix is placing the boundary correctly, not stripping the hook.
- **Assuming `fetch` caching behavior from memory.** Default caching semantics changed across major versions (cached-by-default pre-v15, opt-in after) — check the version before assuming data freshness.
- **Route handler location/signature drift** between `app/api/*/route.ts` and the older `pages/api/*.ts` — don't mix the two conventions in one change.

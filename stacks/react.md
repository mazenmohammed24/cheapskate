# React — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in React code, on top of the core Cheapskate rules.

- **Stale closures from wrong/missing dependency arrays** in `useEffect`/`useCallback`/`useMemo` — compiles fine, runs fine in the obvious case, then reads stale values later. Don't disable `exhaustive-deps` to silence the warning; understand why the dependency is flagged.
- **Reflexive memoization.** Wrapping everything in `useMemo`/`useCallback`/`React.memo` because a re-render is "possible" adds complexity and can be slower than the re-render it prevents. Only memoize a re-render you've actually observed as a problem.
- **Mutating state directly** (`state.push(...)`, `state.x = y`) instead of creating a new reference — no error, just a component that silently doesn't re-render.
- **Array index as `key`** in a list that can reorder or have items removed — passes review, breaks on reorder/delete.
- **Assuming API surface without checking the major version.** `use()`, form actions (`useActionState`), and ref-as-prop are React 19+; don't assume they're available without checking `package.json`.

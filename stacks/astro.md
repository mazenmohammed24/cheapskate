# Astro — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Astro code, on top of the core Cheapskate rules.

- **Forgetting Astro ships zero JS by default.** A component needs an explicit `client:*` directive (`client:load`, `client:visible`, `client:idle`, etc.) to hydrate at all — without one, interactivity code just never runs client-side.
- **Over-hydrating.** Slapping `client:load` on everything defeats Astro's whole performance model — match the directive to how the component is actually used (`client:visible` for below-the-fold, `client:idle` for low-priority).
- **Assuming cross-framework islands "just work."** Each framework island (React/Vue/Svelte) needs its own integration configured and its own hydration directive — they don't share state or lifecycle the way components in a single-framework app would.

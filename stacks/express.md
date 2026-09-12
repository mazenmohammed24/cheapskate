# Node.js / Express — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Node/Express code, on top of the core Cheapskate rules.

- **Mixed error-handling styles.** Combining callback-style, `.then()`, and `async/await` error handling in one codebase means an unhandled promise rejection inside a route handler doesn't automatically become a clean 500 — depending on Node version/config it can crash the process or vanish silently unless it's explicitly caught or routed through error-handling middleware.
- **Blocking the event loop.** Synchronous CPU-heavy work in a request handler (`JSON.parse` on huge payloads, sync crypto, sync file I/O) stalls every concurrent request, not just the one that triggered it.
- **Forgetting `next(err)`.** An Express error-handling middleware that's technically defined but never reached because an earlier handler didn't forward the error — looks like error handling exists when it doesn't fire.

# NestJS — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in NestJS code, on top of the core Cheapskate rules.

- **Provider scope confusion.** Assuming everything is a stateless singleton (an Express habit) breaks when a provider is actually `REQUEST`- or `TRANSIENT`-scoped — injecting a request-scoped provider into a singleton throws at startup in a way that's confusing without knowing Nest's scoping rules first.
- **Circular dependencies handled wrong.** A legitimate cycle between modules/providers needs `forwardRef()` — "just restructure the imports" isn't automatically the right fix if the cycle is intentional and documented.
- **Wrong assumptions about request lifecycle order.** Guards, interceptors, and pipes execute in a specific documented order that isn't the same as generic Express middleware chaining — don't assume linear middleware-style execution.

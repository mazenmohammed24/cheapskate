# Spring Boot — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Spring Boot code, on top of the core Cheapskate rules.

- **`javax.*` vs `jakarta.*` namespace confusion.** Spring Boot 3.x moved from `javax.*` to `jakarta.*` — training data spans the migration, so guessing the wrong namespace from memorized examples is a very common, very simple compile failure. Check the actual Spring Boot major version before assuming either.
- **Wrong bean scope assumptions.** Injecting a `prototype`-scoped bean into a `singleton` bean without realizing the prototype bean is now only ever created once, defeating its purpose.
- **Field injection where the project uses constructor injection.** `@Autowired` on a field instead of matching an existing codebase convention of constructor injection (often enforced for immutability/testability) — check existing classes before adding a new one that breaks the pattern.

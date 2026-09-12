# Angular — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Angular code, on top of the core Cheapskate rules.

- **Assuming NgModules when the project uses standalone components** (default since v14+, the recommended default since v17+) — adding a component to a `declarations` array in a module that no longer exists in a standalone-only project.
- **Unsubscribed RxJS subscriptions.** A raw `.subscribe()` without `takeUntilDestroyed()`, the `async` pipe, or an equivalent teardown leaks and can double-fire on repeated component creation/destruction. Check what the codebase already uses before adding a new subscription pattern.
- **Zone.js change-detection assumptions in a zoneless/signals-based project.** Newer Angular versions support signals and zoneless change detection — manual `markForCheck()`/`detectChanges()` assumptions from a Zone.js mental model don't transfer directly.
- **Mixing constructor-injection and `inject()`** inconsistently within the same file instead of matching the file's existing convention.

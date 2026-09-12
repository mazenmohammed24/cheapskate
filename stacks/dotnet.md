# .NET / ASP.NET Core (C#) — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in .NET/C# code, on top of the core Cheapskate rules.

- **Blocking on async code.** Using `.Result` or `.Wait()` instead of `await` is a classic deadlock source in contexts with a synchronization context, and a common way an AI "fixes" an async signature mismatch by force-unwrapping a `Task` instead of propagating `async`/`await` up the call stack.
- **Null-forgiving operator as a substitute for null handling.** Suppressing a nullable-reference-type warning with `!` instead of actually handling the null case compiles clean and defers exactly the bug the feature exists to catch.
- **Wrong DI lifetime.** Registering a service as `Singleton` when it captures a `Scoped` dependency (like a `DbContext`) works in a quick manual test and breaks under concurrent requests, since the captured scoped instance ends up shared and reused incorrectly.

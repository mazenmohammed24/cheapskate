# Go — Known AI-Agent Failure Modes

Language-specific patterns an agent commonly gets wrong in Go code, on top of the core Cheapskate rules.

- **Ignoring a returned `error`.** Discarding it (`_ = someCall()`) or simply not checking it compiles fine and silently throws away the exact failure information Go's whole design assumes gets handled.
- **Goroutine leaks.** Launching a goroutine that blocks forever on an unbuffered channel with no reader, or with no `context.Context` cancellation path, doesn't crash — it just leaks resources slowly and invisibly.
- **Using `panic`/`recover` for ordinary control flow** instead of returned errors — works, but fights both the language's idioms and the rest of the codebase's expectations about how failures propagate.

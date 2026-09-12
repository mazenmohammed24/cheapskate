# FastAPI — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in FastAPI code, on top of the core Cheapskate rules.

- **Blocking the event loop from an `async def` route.** Calling a blocking DB driver, a sync HTTP client, or sync file I/O inside an `async def` handler stalls the entire event loop for every concurrent request. If the underlying call is genuinely blocking, the handler should be a plain `def` instead — FastAPI runs those in a thread pool automatically.
- **Pydantic v1/v2 syntax mismatch.** `.dict()`/`class Config` (v1) and `.model_dump()`/`model_config` (v2) are not interchangeable — this is one of the most common version-confusion mistakes in the current ecosystem. Check which major version the project pins before assuming either.
- **Bypassing the project's DI convention.** Reaching for a module-level global instead of the existing `Depends()`-based injection pattern the codebase already uses.

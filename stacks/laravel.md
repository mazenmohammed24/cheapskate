# Laravel — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Laravel code, on top of the core Cheapskate rules.

- **N+1 queries.** Accessing an Eloquent relationship inside a loop without eager loading (`with()`) — same shape as the equivalent Django/Rails mistake, just a different API.
- **Assuming an old project structure.** Laravel 11 removed `app/Http/Kernel.php` and much of the old scaffolding in favor of `bootstrap/app.php` — adding middleware "the old way" edits a file that may not exist, or isn't read, in a Laravel 11+ app. Check the actual version and structure before assuming either convention.
- **Mass-assignment exposure.** Adding a new field to a `create()`/`update()` call without checking the model's `$fillable`/`$guarded` first.

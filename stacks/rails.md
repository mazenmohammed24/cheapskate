# Ruby on Rails — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Rails code, on top of the core Cheapskate rules.

- **N+1 queries.** Missing `includes`/`eager_load` on an association accessed in a loop — the same ORM-shaped mistake as Django and Laravel, just Rails' API surface.
- **Overusing ActiveRecord callbacks** (`before_save`, `after_commit`, etc.) for business logic that belongs in a service object — works, but creates side effects that fire from unexpected places (a console session, a seed script, a test factory) and are hard to trace back to their cause.
- **Assuming Rails 7 defaults on an older app.** Hotwire/Turbo and import maps are Rails 7 defaults — an app still on Webpacker/UJS has a different asset pipeline, and assuming the newer convention applies is a common version-confusion mistake. Check what's actually configured before assuming either.

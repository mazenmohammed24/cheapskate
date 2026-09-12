# SQL / Relational Databases — Known AI-Agent Failure Modes

Cross-framework patterns an agent commonly gets wrong when touching Postgres/MySQL/any relational DB, on top of the core Cheapskate rules. Every ORM-specific N+1 entry elsewhere in `stacks/` (Django, Laravel, Rails, ...) is a symptom of this same underlying layer.

- **Irreversible or unguarded migrations.** A schema migration that drops a column, changes a type, or otherwise touches existing data, run without a reversible path, a backup, or a transaction, is the single highest blast-radius mistake anywhere in this rule set — treat it as high-stakes (see `HIGH_STAKES.md`) rather than a routine edit.
- **Fixing a slow query at the wrong layer.** Adding application-level caching or restructuring code to work around what `EXPLAIN ANALYZE` would show is actually a missing index is a much more expensive fix for the same problem — check the query plan before assuming the code is at fault.
- **The N+1 pattern itself.** A query issued inside a loop instead of one batched/joined query is the same mistake regardless of which ORM or framework triggered it — worth checking for directly, not just trusting a framework-specific eager-loading call to have been used correctly.

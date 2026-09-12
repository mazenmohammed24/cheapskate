# Django — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Django code, on top of the core Cheapskate rules.

- **N+1 queries.** Accessing a related object's fields inside a loop without `select_related`/`prefetch_related` runs correctly — it just silently issues hundreds of extra queries the ORM never warns about.
- **Hand-editing migrations.** Writing or editing a migration file by hand instead of generating it with `makemigrations`, or editing one that's already been applied/shared, breaks migration history in ways that only surface for other developers or environments later.
- **Guessing `settings.py` behavior.** Many projects split settings by environment (`settings/dev.py`, `settings/prod.py`) — check the actual settings module in use rather than assuming defaults from memory.

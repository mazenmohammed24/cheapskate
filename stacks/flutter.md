# Flutter / Dart — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in Flutter/Dart code, on top of the core Cheapskate rules.

- **Unnecessary rebuild scope.** Skipping `const` constructors where possible, or putting state high in the widget tree when only a small subtree needs it, is Flutter's most common "looks fine, quietly slow" mistake.
- **Mixing state-management approaches.** Introducing Provider, Riverpod, Bloc, or GetX patterns interchangeably instead of matching whatever `pubspec.yaml` shows the project already standardized on.
- **Leaking controllers.** Not disposing `TextEditingController`, `AnimationController`, `StreamSubscription`, etc. in `dispose()` — no immediate error, just a leak that compounds as the widget is created and destroyed repeatedly.

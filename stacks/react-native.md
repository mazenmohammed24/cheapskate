# React Native — Known AI-Agent Failure Modes

Framework-specific patterns an agent commonly gets wrong in React Native code, on top of the core Cheapskate rules.

- **Assuming web layout defaults.** Flexbox's default `flexDirection` is `column` in React Native, not `row` like the web — and there's no CSS cascade/inheritance the way there is in a browser.
- **Using web-only APIs.** DOM globals, `window`, and certain browser storage APIs don't exist on-device — this compiles as plain JS but crashes or no-ops at runtime, not at type-check time unless the types are properly platform-scoped.
- **Ignoring platform-specific files and workflow differences.** Not using `.ios.js`/`.android.js` splits when behavior genuinely needs to differ per platform, or assuming Expo-managed-workflow APIs are available in a bare React Native project (or vice versa) without checking which one the project actually is.

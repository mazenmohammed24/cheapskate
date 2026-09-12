# Benchmarks

Real numbers, run against the actual repo, not estimated. This page gets appended to as more stacks are tested — see the pilot batch below for the current state.

## Methodology (same for every stack tested)

For each stack: a small, isolated fixture project (order pricing — discount, tax, shipping — across a handful of files, with decoy files unrelated to the bug) is set up twice, as two separate git repos. One agent gets the task with no Cheapskate instructions. The other gets the identical task with the Cheapskate core rules plus that stack's `stacks/<name>.md` file prepended. Same underlying model, same tool access, same task text, same bug, isolated copies so neither run can see the other. Both runs' final diffs and test results are verified afterward to confirm they reached the same correct fix — this page only compares cost, never a case where one run was more correct than the other. Numbers come straight from the harness's own per-run usage report, not an estimate.

## Pilot batch — 5 stacks (2026-09-13)

Scope for this pilot: stacks where the toolchain was already installed on the test machine (Node.js, Python) or needed under 100MB to add — a deliberately cheap first slice, not the full 20. Full methodology note: this is one trial per condition per stack, not an average over repeated runs — treat magnitudes as directional.

| Stack | Condition | Tokens | Tool calls | Wall time | Tests |
|---|---|---:|---:|---:|---:|
| Express (Node.js) | Baseline | 54,689 | 14 | 52.1s | 5/5 |
| Express (Node.js) | Cheapskate | 59,711 (+9.2%) | 14 (+0%) | 67.0s (+28.5%) | 5/5 |
| React | Baseline | 63,405 | 17 | 115.2s | 5/5 |
| React | Cheapskate | 57,978 (−8.6%) | 14 (−17.6%) | 62.2s (−46.0%) | 5/5 |
| TypeScript | Baseline | 64,510 | 23 | 100.8s | 5/5 |
| TypeScript | Cheapskate | 61,130 (−5.2%) | 15 (−34.8%) | 59.6s (−40.8%) | 5/5 |
| FastAPI (Python) | Baseline | 57,315 | 13 | 106.5s | 5/5 |
| FastAPI (Python) | Cheapskate | 58,934 (+2.8%) | 11 (−15.4%) | 48.0s (−54.9%) | 5/5 |
| Django (Python) | Baseline | 55,539 | 12 | 68.7s | 5/5 |
| Django (Python) | Cheapskate | 59,278 (+6.7%) | 13 (+8.3%) | 57.3s (−16.6%) | 5/5 |
| **Total (5 stacks)** | **Baseline** | **295,458** | **79** | **443.3s** | — |
| **Total (5 stacks)** | **Cheapskate** | **297,031 (+0.5%)** | **67 (−15.2%)** | **294.2s (−33.6%)** | — |

Every run reached the identical correct two-line fix and left the suite fully passing — this batch is a cost comparison only, not a quality one.

### The honest part: Express regressed

On Express specifically, Cheapskate used *more* tokens (+9.2%) and *more* time (+28.5%) than the baseline, for the same tool-call count. Looking at what each run actually did: the baseline agent happened to infer the bug straight from reading the source and test assertions, running the suite only once, at the end, to confirm. The Cheapskate run followed its own discipline more literally — checking state, reproducing the failure by running the suite first, then verifying again after the fix — which is the right instinct on a task with any real uncertainty, but pure overhead on a task this small where the baseline's shortcut happened to work.

This is exactly the tradeoff [`HIGH_STAKES.md`](HIGH_STAKES.md) and the "this file has a cost too" rule already warn about in the abstract: the rule set is a fixed cost paid on every invocation, and on a task small enough, that fixed cost can outweigh what it saves. Four of five stacks came out ahead — often by a lot on wall time — but Express is the counter-example, kept in this table rather than left out of it.

### Aggregate read

Across the 5-stack pilot: tokens were roughly a wash (+0.5%, within noise for a single trial each), tool calls dropped ~15%, and wall time dropped ~34%. The time drop is the most consistent signal across stacks — fewer redundant verification passes and less re-reading tends to shorten the critical path even on runs where token count didn't move much.

## Running your own

The fixture generator and both benchmark harnesses (the original single-stack ShopKit test and this multi-stack pilot) aren't published in this repo — they're throwaway scaffolding, git-ignored under `bench/`. The method above is exact enough to reproduce: pick a stack, write a small buggy project with an objective pass/fail test, run the same task with and without the relevant rule files, compare the usage report.

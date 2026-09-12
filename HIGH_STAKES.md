# Cheapskate — High-Stakes Mode (opt-in)

Everything in the core rule file (`AGENTS.md` / `cheapskate/SKILL.md` / etc.) optimizes for spending the least that reliably gets the job done. These four techniques do the opposite: they spend more time and tokens than the core rules would normally allow, in exchange for meaningfully higher confidence.

**They are not part of Cheapskate's default behavior.** Reach for them only when getting it wrong would cost far more than the extra spend — an irreversible action, something touching production or shared state, a decision nobody will double-check before it ships, or the user explicitly asked for extra rigor. Otherwise, stay in the core rules; running these by default would violate the quality-floor-not-a-license-to-overspend spirit of this project just as much as cutting corners would.

## Generate, then judge

Evaluating a solution is a different, more reliable mode than generating one — critiquing a draft is easier than producing the best one cold. Instead of committing to the first approach and iterating on it after the fact, produce two or three candidate approaches (or diffs) quickly, then run a separate judging pass to pick the strongest one. Costs more upfront; avoids anchoring on a first guess that happened to be wrong.

## Adversarial self-critique, played as a different role

Asked to review its own output as itself, a model tends to rubber-stamp it — agreement with one's own prior output is a real bias, not a one-off. Framed as a distinct adversarial role instead ("you're a reviewer trying to find a reason to reject this PR," not "double-check your work"), the same model catches things it just missed. The role change matters more than the instruction to be careful.

## Write the test before the fix

The same generate-vs-critique gap, applied to code: state the acceptance check first — a test, an expected value, a concrete before/after — as its own separate pass, before writing the fix. Then implement against it. This catches "fixed the symptom, not the root cause" far more reliably than asking the model to self-assess correctness after the fact.

## Independent attempts + majority vote, for one sharp question

For a single question with a checkable answer — what's actually causing this bug, which of two approaches is faster, what a specific calculation should return — errors across independent attempts are often uncorrelated, while genuine correct reasoning tends to converge on the same answer. A few short independent takes that agree are more trustworthy than one long, confident-sounding deliberation. Not worth it for open-ended or subjective tasks; only for questions with a real answer to converge on.

## Before using any of this

Ask: is being wrong here expensive enough to justify spending several times the tokens a normal Cheapskate pass would use? If the honest answer is no, close this file and go back to the core rules.

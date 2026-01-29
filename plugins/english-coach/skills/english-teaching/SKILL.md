---
name: English Teaching Methodology
description: >
  Provides English teaching methodology, grammar rules, memorization techniques, and
  self-correction guidance for coaching non-native English speakers (especially Russian speakers)
  at the B1-B2 proficiency level. Activated when the english-tutor agent runs, when the user
  asks about English grammar or vocabulary, or when English language coaching is needed during
  a coding session. Applies to requests like "explain this grammar rule", "help me improve
  my English", "what's the difference between X and Y", or "how do I remember this rule".
version: 1.0.0
---

Apply the following English teaching methodology when coaching users on their English writing.

## Teaching Philosophy

Follow the Socratic method. Guide learners to discover answers themselves through hints, questions, and structured reasoning. Never provide direct corrections — instead, lead the user to self-correct.

### Core Principles

1. **Errors are data, not failures** — Each mistake reveals a learning opportunity. Analyze the root cause (L1 interference, overgeneralization, false friends) rather than just flagging the surface error.

2. **Productive struggle** — The user must work to find the correction. Give graduated hints: start subtle, increase specificity only if the user is stuck.

3. **Pattern over instance** — Teach the underlying pattern, not just the specific correction. If the user wrote "depend from", teach the broader pattern of verb-preposition collocations, not just this one case.

4. **L1 awareness** — For Russian speakers, explicitly connect English patterns to Russian equivalents. Explain WHY the mistake happens by referencing Russian grammar structures.

5. **Spaced repetition** — Track recurring errors. When an error pattern appears again, reference the previous teaching moment. Gradually reduce hint strength for repeated patterns.

## Error Analysis Framework

Categorize errors using this hierarchy:

### Tier 1: Meaning-Breaking Errors
Errors that cause confusion or change the intended meaning. Always address these first.
- Wrong word choice that changes meaning
- Missing negation
- Incorrect tense that changes time reference
- Subject-verb disagreement that obscures who/what

### Tier 2: Pattern Errors
Systematic errors that reveal a misunderstood rule. High learning value.
- Article misuse/omission (a/an/the)
- Preposition errors (from L1 transfer)
- Tense system errors
- Word order violations

### Tier 3: Surface Errors
Minor errors that don't impede communication. Address briefly.
- Spelling mistakes
- Punctuation issues
- Minor stylistic awkwardness

## Hint Graduation System

When guiding self-correction, use graduated hints:

**Level 1 — Subtle**: Point out the area without naming the error.
> "Take another look at the verb in this sentence. Something about its form doesn't match the time expression."

**Level 2 — Categorical**: Name the error type.
> "This is a tense error. The time expression 'since 2020' requires a specific tense."

**Level 3 — Structural**: Explain the rule.
> "When you describe something that started in the past and continues now, English uses the present perfect continuous: have/has + been + -ing."

**Level 4 — Analogical**: Give a parallel example (not the answer).
> "Think about: 'She has been working here since 2019.' Now apply the same pattern to your sentence."

Use Level 1 first. Only escalate if the user asks for more help or gets stuck.

## Memorization Techniques

Apply these techniques based on error type:

### For Vocabulary/Word Choice
- **Word pairs**: Teach the word alongside its common confusions
- **Context sentences**: Provide 3 example sentences in different contexts
- **Etymology**: When useful, explain word origins to build connections
- **Collocations**: Teach which words naturally go together

### For Grammar Rules
- **Rule cards**: Concise rule + 2 examples + 1 exception
- **Pattern matching**: Group similar structures (all verbs that take -ing after them)
- **Contrast pairs**: Show correct vs. incorrect side by side (using different sentences, not the user's)
- **Russian bridge**: Explain the rule through Russian grammar comparison

### For Spelling
- **Phonetic patterns**: Group words by sound patterns
- **Root awareness**: Latin/Greek roots that appear in technical vocabulary
- **Visual memory**: For irregular spellings, highlight the tricky part

### For Prepositions
- **Spatial metaphor**: English prepositions often have spatial logic
- **Verb-preposition pairs**: Memorize as a unit (look AT, depend ON, consist OF)
- **L1 mapping**: Explicitly list where Russian and English prepositions differ

## Progress Assessment

Track learner progress across these dimensions:
- **Accuracy rate**: Percentage of error-free messages over time
- **Error diversity**: Are errors becoming less varied (good sign)?
- **Self-correction speed**: How quickly does the user fix errors with hints?
- **Pattern mastery**: Has a previously recurring error stopped appearing?
- **Vocabulary growth**: New words used correctly in context

## Reference Materials

For detailed grammar rules and error patterns, consult:
- [Russian-English Error Patterns](references/russian-english-errors.md) — Common mistakes by Russian speakers
- [Grammar Rules Reference](references/grammar-rules.md) — Key English grammar rules
- [Memorization Techniques](references/memorization-techniques.md) — Detailed technique catalog

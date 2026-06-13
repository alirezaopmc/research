// Weekly report instance. Run `make new PROJECT=<project> WEEK=<id>` and fill in.
// Path assumes instances/<project>/<week>.typ (two levels under src/).
#import "../../templates/weekly-report.typ": *

#show: weekly-report.with(
  number: 1,
  period: "Mon DD - Mon DD, YYYY",
  project: "Hallucination in Large Language Models",
)

#tldr[
  One or two sentences summarizing the week's most important outcome.
]

#highlights(
  [Most important outcome or metric from this week.],
  [Main blocker or risk, if any.],
  [Key decision or direction for next week.],
)

#accomplishments(
  research: [
    - Read and summarized *[Author, Year]* on [concept]; found a gap in their
      handling of [variable/method].
  ],
  implementation: [
    - Implemented the [module/algorithm] using [tool].
    - Ran initial experiments on [dataset]; [X]% improvement in [metric] vs baseline.
  ],
  writing: [
    - Drafted the [section] for [chapter/paper].
  ],
)

#challenges(
  technical: (
    (
      issue: [Encountered [error/bottleneck] when [action].],
      tried: [Optimized [X] and checked the docs, but [why it didn't fully work].],
    ),
  ),
  theoretical: (
    [Unsure whether to prioritize [Approach A] or [Approach B] for the next phase,
      given the constraints of our setup.],
  ),
)

#goals[
  - Resolve the current blocker regarding [Issue].
  - Begin the main benchmark evaluations.
  - Read 2 papers on [Topic] to address the theoretical question above.
]

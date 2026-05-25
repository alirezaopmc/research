# LLM Techniques

## Positioning

Foundations for working with LLMs at inference time: **in-context learning**, **prompting**, and **context engineering** (retrieval, memory, tools, multi-agent orchestration). No training-scale compute required to start.

## Core Questions

- When do few-shot demonstrations help, and how should they be chosen and ordered?
- Which prompting patterns (CoT, RAG, verification, structured output) fit which tasks?
- How should context be retrieved, compressed, and managed for long-horizon use?
- What fails when context is wrong, stale, or overloaded?

## Why It Is Market-Relevant

- Product teams ship via prompts, RAG, and agents—not always fine-tuning.
- Context limits and cost dominate production systems.
- Surveys map the design space before committing to a stack.

## Low-Compute Strategy

- Read survey papers first; extract a personal taxonomy.
- Reproduce small prompting/ICL baselines on open models or APIs.
- Prototype one RAG or tool-use pipeline before any post-training.

## Related Papers

- [[papers/llm-techniques/in-context-learning-survey]]
- [[papers/llm-techniques/prompt-engineering-survey]]
- [[papers/llm-techniques/context-engineering-survey]]

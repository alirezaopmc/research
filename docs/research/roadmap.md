# Roadmap: LLM Techniques

## TL;DR

Build a solid map of **in-context learning**, **prompt engineering**, and **context engineering** via three survey papers—then apply patterns to small, inference-only experiments.

## Why This Field Fits

- **Compute:** survey + prompting/RAG work fits API models and small open weights; no H100 training required.
- **Hype / market:** agents, RAG, and context windows are central to current LLM products.
- **Industry:** most deployments are prompt- and context-driven before any fine-tuning.

## Research Wedge

Focus on:

> How do you design and manage context so LLMs are reliable, cheap, and maintainable?

Good subproblems:

- Demonstration selection and ordering for ICL.
- Prompt patterns for reasoning, retrieval, and verification.
- RAG, memory, and tool context under token budgets.
- Evaluation: when does a technique actually help on your task?

## Reading Order

1. [[papers/llm-techniques/in-context-learning-survey]] — ICL foundations (demonstrations, training, mechanisms).
2. [[papers/llm-techniques/prompt-engineering-survey]] — prompting taxonomy (CoT, RAG, ReAct, tool-use patterns).
3. [[papers/llm-techniques/context-engineering-survey]] — context pipelines (RAG, memory, multi-agent).

## First 30 Days

- Week 1: read ICL survey; note demonstration-selection and failure modes.
- Week 2: read prompt-engineering survey; shortlist 3–5 patterns for your tasks.
- Week 3: read context-engineering survey; sketch one context stack (retrieve → compress → act).
- Week 4: run one small benchmark (e.g. few-shot vs zero-shot, or naive RAG vs none) on a fixed task.

## Project Ideas

- **ICL ablation:** same task, vary demo count/order; log accuracy and cost.
- **Prompt pattern shootout:** CoT vs self-consistency vs RAG on one QA set.
- **Context budget study:** truncate/compress context; measure quality vs tokens.
- **Failure taxonomy:** catalog hallucination modes tied to context mistakes.

## Avoid For Now

- Treating survey reading as substitute for one hands-on baseline per technique.
- Jumping to fine-tuning before inference-time options are exhausted.

# Roadmap: RL for LLM Agents

## TL;DR

Best research bet: **low-compute RL and RL-adjacent methods for LLM agents**: tool use, web/code agents, preference optimization, feedback loops, and evaluation.

This is better than classic deep RL for you because it has stronger hype, clearer industry demand, and can be studied without training giant models from scratch.

## Why This Field Fits

- **Compute:** many useful projects can run with small models, existing APIs, synthetic tasks, logged traces, or preference datasets.
- **Hype / market:** agents, RLHF, post-training, tool-use learning, and autonomous workflows are hot.
- **Industry:** maps to coding agents, customer-support agents, data-analysis agents, workflow automation, recommender/ranking systems, and model evaluation.

## Research Wedge

Focus on:

> How can small LLM agents learn from feedback, preferences, and environment outcomes under tight compute limits?

Good subproblems:

- Agent evaluation: reliable benchmarks for tool-use and long-horizon tasks.
- Feedback learning: using successes/failures, critiques, rewards, and preferences.
- Low-cost post-training: DPO/RLAIF-style methods instead of expensive PPO.
- Agent memory and self-improvement: what should be stored, revised, or discarded?
- Credit assignment: identifying which action in a trajectory caused success/failure.

## Reading Order

1. [[papers/instructgpt-rlhf]] — RLHF foundation.
2. [[papers/webgpt]] — RLHF for browser/tool use.
3. [[papers/react]] — reasoning + acting agent pattern.
4. [[papers/toolformer]] — self-supervised tool-use learning.
5. [[papers/reflexion]] — lightweight feedback/self-improvement loop.
6. [[papers/voyager]] — long-horizon agent skill library.
7. [[papers/direct-preference-optimization]] — simpler alternative to PPO-style RLHF.
8. [[papers/constitutional-ai]] — AI feedback and RLAIF.
9. [[papers/self-rewarding-language-models]] — model-generated rewards for improvement.

## First 30 Days

- Week 1: read RLHF, ReAct, WebGPT.
- Week 2: read Toolformer, Reflexion, Voyager.
- Week 3: read DPO, Constitutional AI, Self-Rewarding LMs.
- Week 4: reproduce a small agent benchmark with no training: ReAct vs Reflexion on a toy tool-use task.

## Project Ideas

- **Low-compute Reflexion benchmark:** compare plain ReAct vs ReAct + verbal feedback on small tasks.
- **Preference data for agents:** collect trajectory pairs and train/evaluate a small reward or preference model.
- **Agent credit assignment:** label which step caused failure and test whether targeted feedback beats whole-trajectory feedback.
- **Tool-use safety:** measure when agents call tools unnecessarily, hallucinate tool outputs, or loop.

## Avoid For Now

- Atari/MuJoCo deep RL as the main research identity.
- Training RL agents from scratch at scale.
- Robotics RL unless you have hardware access or strong simulation support.

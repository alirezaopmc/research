# RL for LLM Agents

## Positioning

This topic combines reinforcement learning, preference optimization, and LLM agents. The goal is not to compete with frontier labs on training scale. The goal is to become strong at **feedback-driven agent improvement under limited compute**.

## Core Questions

- How should an LLM agent learn from failed trajectories?
- When is prompting enough, and when is training needed?
- Can preference optimization replace expensive online RL for agent behavior?
- How do we assign credit across long tool-use trajectories?
- What evaluation actually predicts useful industry deployment?

## Why It Is Market-Relevant

Industry wants agents that can:

- use tools reliably;
- recover from errors;
- follow business policies;
- perform multi-step work;
- improve from logs and user feedback.

This connects directly to coding agents, support automation, browser agents, data agents, and internal workflow automation.

## Low-Compute Strategy

- Prefer small benchmarks and existing environments.
- Use small open models or API models for inference-heavy experiments.
- Start with no-training baselines: ReAct, Reflexion, tool-use prompting.
- Move later to lightweight post-training: DPO, LoRA, reward modeling on small preference sets.
- Evaluate carefully instead of chasing SOTA.

## Concepts To Master

- RLHF and PPO basics.
- Preference optimization: DPO, IPO/KTO-style objectives.
- Contextual bandits and offline feedback.
- Agent trajectories, rewards, and credit assignment.
- Tool-use benchmarks and failure analysis.
- Evaluation design: success rate, cost, latency, recovery, safety.

## Related Papers

- [[papers/instructgpt-rlhf]]
- [[papers/webgpt]]
- [[papers/react]]
- [[papers/toolformer]]
- [[papers/reflexion]]
- [[papers/voyager]]
- [[papers/direct-preference-optimization]]
- [[papers/constitutional-ai]]
- [[papers/self-rewarding-language-models]]

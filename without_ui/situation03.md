# Situation 03 — Single Agent / Going to Production

**Use when:** One agent, but it's shipping. Needs persistence, observability, and config management.  
**Philosophy:** Simple core with production-grade additions for state, memory, and observability. No orchestration overhead yet — add it when a second agent appears.

## Tree

```
repo/
├─ src/
│  ├─ agents/
│  │  └─ <your_agent>/           # single agent, fully co-located
│  │     ├─ prompt.md
│  │     ├─ agent.py
│  │     ├─ tools.py
│  │     └─ tests/
│  ├─ tools/                     # shared tool adapters + base interface
│  ├─ memory/
│  │  ├─ short_term/
│  │  └─ long_term/
│  ├─ state/                     # task state and checkpoints
│  ├─ schemas/                   # Pydantic / JSON schemas
│  ├─ policies/                  # safety rules, rate limits, approvals
│  ├─ models/                    # provider abstraction + cache
│  │  └─ cache/
│  ├─ observability/             # logs, traces, metrics
│  ├─ evals/                     # prompt evals and scoring
│  └─ shared/                    # common utils
├─ configs/
│  ├─ agents/
│  ├─ models/
│  └─ environments/
├─ prompts/
│  ├─ system/
│  └─ tasks/
├─ tests/
│  ├─ unit/
│  ├─ integration/
│  └─ fixtures/
├─ scripts/
│  ├─ bootstrap/
│  └─ migrations/
├─ docs/
│  ├─ runbooks/
│  └─ adr/
├─ data/
│  └─ eval_sets/
├─ .claude/
│  └─ CLAUDE.md
└─ README.md
```

## Paths

```paths
src/agents/my_agent/tests
src/tools
src/memory/short_term
src/memory/long_term
src/state
src/schemas
src/policies
src/models/cache
src/observability
src/evals
src/shared
configs/agents
configs/models
configs/environments
prompts/system
prompts/tasks
tests/unit
tests/integration
tests/fixtures
scripts/bootstrap
scripts/migrations
docs/runbooks
docs/adr
data/eval_sets
.claude
```

## Stub Files

```stubs
README.md
.claude/CLAUDE.md
.env.example
.gitignore
src/agents/my_agent/prompt.md
src/agents/my_agent/agent.py
src/agents/my_agent/tools.py
src/tools/base.py
```

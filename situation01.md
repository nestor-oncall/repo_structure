# Situation 01 — Solo Agent / Prototype / Short Scope

**Use when:** Single agent, proof-of-concept, under one week scope.  
**Philosophy:** Minimum viable structure. Add folders only when the need is felt, not anticipated.

## Tree

```
repo/
├─ src/
│  ├─ agents/          # agent definition, prompt, tools (all co-located)
│  ├─ tools/           # shared tool adapters (if any)
│  ├─ schemas/         # Pydantic / JSON input-output schemas
│  ├─ evals/           # prompt evals and scoring
│  └─ shared/          # common utils, logging, helpers
├─ prompts/            # system and task prompts
├─ tests/              # unit and basic integration tests
├─ configs/            # env-specific config files
├─ data/
│  └─ eval_sets/       # eval inputs and expected outputs
├─ .claude/
│  └─ CLAUDE.md        # Claude Code context file
└─ README.md
```

## Paths

```paths
src/agents
src/tools
src/schemas
src/evals
src/shared
prompts
tests
configs
data/eval_sets
.claude
```

## Stub Files

```stubs
README.md
.claude/CLAUDE.md
.env.example
.gitignore
```

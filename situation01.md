# Situation 01 — Solo Agent / Prototype / Short Scope

**Use when:** Single agent, proof-of-concept, under one week scope.  
**Philosophy:** Minimum viable structure. Streamlit for UI — co-located with the Python backend, zero build tooling.

## Stack
- **UI:** Streamlit (multipage)
- **Backend:** Python, co-located with agent

## Tree

```
repo/
├─ src/
│  ├─ agents/               # agent definition, prompt, tools (all co-located)
│  ├─ tools/                # shared tool adapters (if any)
│  ├─ schemas/              # Pydantic / JSON input-output schemas
│  ├─ evals/                # prompt evals and scoring
│  └─ shared/               # common utils, logging, helpers
├─ ui/                      # Streamlit frontend
│  ├─ app.py                # entrypoint — streamlit run ui/app.py
│  ├─ pages/                # multipage: 1_chat.py, 2_settings.py …
│  └─ components/           # reusable Streamlit component functions
├─ prompts/                 # system and task prompts
├─ tests/                   # unit and basic integration tests
├─ configs/                 # env-specific config files
├─ data/
│  └─ eval_sets/            # eval inputs and expected outputs
├─ .claude/
│  └─ CLAUDE.md
├─ requirements.txt
└─ README.md
```

## Paths

```paths
src/agents
src/tools
src/schemas
src/evals
src/shared
ui/pages
ui/components
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
requirements.txt
ui/app.py
ui/pages/1_chat.py
ui/components/__init__.py
```

# Situation 02 — Multi-Agent / Production Intent

**Use when:** Multiple agents, orchestration required, shipping to production.  
**Philosophy:** Every concern gets its own module. Entrypoints are thin. Prompts, policies, and state are first-class. Next.js frontend talks exclusively through its own API routes — the Python backend is never called directly from the browser.

## Stack
- **UI:** Next.js 14 App Router
- **Components:** shadcn/ui
- **Styling:** TailwindCSS
- **Data fetching:** TanStack Query
- **File uploads:** Uppy + AWS S3
- **Global state:** Zustand
- **API layer:** Next.js API routes (all browser → backend calls go here)
- **Testing:** Vitest + React Testing Library

## Tree

```
repo/
├─ apps/
│  ├─ web/                              # Next.js 14 App Router
│  │  ├─ app/
│  │  │  ├─ (auth)/                    # route group: login, signup
│  │  │  ├─ (dashboard)/               # route group: main product UI
│  │  │  ├─ api/                       # Next.js API routes (proxy to Python backend)
│  │  │  │  ├─ agents/
│  │  │  │  ├─ tasks/
│  │  │  │  └─ uploads/                # S3 presigned URL generation
│  │  │  ├─ layout.tsx
│  │  │  └─ page.tsx
│  │  ├─ components/
│  │  │  ├─ ui/                        # shadcn generated components
│  │  │  └─ features/                  # domain-specific composite components
│  │  ├─ lib/
│  │  │  ├─ query/                     # TanStack Query client, hooks, prefetch helpers
│  │  │  ├─ store/                     # Zustand stores (one file per slice)
│  │  │  └─ upload/                    # Uppy instance, S3 plugin config
│  │  ├─ public/
│  │  ├─ styles/
│  │  ├─ tests/                        # Vitest + React Testing Library
│  │  ├─ next.config.ts
│  │  ├─ tailwind.config.ts
│  │  ├─ vitest.config.ts
│  │  ├─ tsconfig.json
│  │  └─ package.json
│  ├─ api/                             # Python HTTP / webhook entrypoints
│  ├─ worker/                          # async jobs, queue consumers
│  └─ cli/                             # local dev and admin commands
├─ src/
│  ├─ orchestrators/                   # workflow controllers (classes, not subdirs)
│  ├─ agents/
│  │  ├─ researcher/
│  │  │  ├─ prompt.md
│  │  │  ├─ agent.py
│  │  │  ├─ tools.py
│  │  │  └─ tests/
│  │  ├─ planner/
│  │  │  ├─ prompt.md
│  │  │  ├─ agent.py
│  │  │  ├─ tools.py
│  │  │  └─ tests/
│  │  ├─ executor/
│  │  │  ├─ prompt.md
│  │  │  ├─ agent.py
│  │  │  ├─ tools.py
│  │  │  └─ tests/
│  │  └─ reviewer/
│  │     ├─ prompt.md
│  │     ├─ agent.py
│  │     ├─ tools.py
│  │     └─ tests/
│  ├─ tools/                           # shared tool adapters + BaseTool interface
│  │  ├─ web_search/
│  │  ├─ browser/
│  │  ├─ code_exec/
│  │  └─ db/
│  ├─ registry/                        # capability map and agent lookup
│  ├─ memory/
│  │  ├─ short_term/
│  │  ├─ long_term/
│  │  └─ episodic/
│  ├─ state/                           # task state machines and checkpoints
│  ├─ schemas/                         # Pydantic / JSON schemas
│  ├─ policies/                        # safety, routing, limits, approvals
│  ├─ models/                          # model / provider abstraction + cache
│  │  └─ cache/
│  ├─ observability/                   # logs, traces, metrics, spans
│  └─ shared/                          # common utils
├─ configs/
│  ├─ agents/
│  ├─ orchestrators/
│  ├─ models/
│  └─ environments/
├─ prompts/
│  ├─ system/
│  ├─ tasks/
│  └─ rubrics/
├─ tests/
│  ├─ unit/
│  ├─ integration/
│  ├─ end_to_end/
│  └─ fixtures/
├─ evals/                              # task-level regression and scoring (not in src/)
├─ scripts/
│  ├─ bootstrap/
│  ├─ replay/                          # replay from observability traces
│  ├─ backfill/
│  └─ migrations/
├─ docs/
│  ├─ architecture/
│  ├─ runbooks/
│  ├─ adr/                             # Architecture Decision Records
│  └─ patterns/
├─ data/
│  ├─ examples/
│  └─ eval_sets/
├─ .claude/
│  ├─ CLAUDE.md
│  └─ skills/
└─ README.md
```

## Paths

```paths
apps/web/app/(auth)
apps/web/app/(dashboard)
apps/web/app/api/agents
apps/web/app/api/tasks
apps/web/app/api/uploads
apps/web/components/ui
apps/web/components/features
apps/web/lib/query
apps/web/lib/store
apps/web/lib/upload
apps/web/public
apps/web/styles
apps/web/tests
apps/api
apps/worker
apps/cli
src/orchestrators
src/agents/researcher/tests
src/agents/planner/tests
src/agents/executor/tests
src/agents/reviewer/tests
src/tools/web_search
src/tools/browser
src/tools/code_exec
src/tools/db
src/registry
src/memory/short_term
src/memory/long_term
src/memory/episodic
src/state
src/schemas
src/policies
src/models/cache
src/observability
src/shared
configs/agents
configs/orchestrators
configs/models
configs/environments
prompts/system
prompts/tasks
prompts/rubrics
tests/unit
tests/integration
tests/end_to_end
tests/fixtures
evals
scripts/bootstrap
scripts/replay
scripts/backfill
scripts/migrations
docs/architecture
docs/runbooks
docs/adr
docs/patterns
data/examples
data/eval_sets
.claude/skills
```

## Stub Files

```stubs
README.md
.claude/CLAUDE.md
.env.example
.gitignore
apps/web/app/layout.tsx
apps/web/app/page.tsx
apps/web/next.config.ts
apps/web/tailwind.config.ts
apps/web/vitest.config.ts
apps/web/tsconfig.json
apps/web/package.json
apps/web/lib/query/client.ts
apps/web/lib/store/index.ts
apps/web/lib/upload/uppy.ts
src/tools/base.py
src/agents/researcher/prompt.md
src/agents/researcher/agent.py
src/agents/researcher/tools.py
src/agents/planner/prompt.md
src/agents/planner/agent.py
src/agents/planner/tools.py
src/agents/executor/prompt.md
src/agents/executor/agent.py
src/agents/executor/tools.py
src/agents/reviewer/prompt.md
src/agents/reviewer/agent.py
src/agents/reviewer/tools.py
```

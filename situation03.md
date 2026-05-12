# Situation 03 — Single Agent / Going to Production

**Use when:** One agent, but it's shipping. Needs persistence, observability, and config management.  
**Philosophy:** Simple agent core with production-grade additions. Next.js frontend in its own `web/` directory, calling the Python backend exclusively through Next.js API routes. No orchestration overhead yet — add it when a second agent appears.

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
├─ web/                                 # Next.js 14 App Router
│  ├─ app/
│  │  ├─ (auth)/                       # route group: login, signup
│  │  ├─ (dashboard)/                  # route group: main product UI
│  │  ├─ api/                          # Next.js API routes (proxy to Python backend)
│  │  │  ├─ agent/
│  │  │  └─ uploads/                   # S3 presigned URL generation
│  │  ├─ layout.tsx
│  │  └─ page.tsx
│  ├─ components/
│  │  ├─ ui/                           # shadcn generated components
│  │  └─ features/                     # domain-specific composite components
│  ├─ lib/
│  │  ├─ query/                        # TanStack Query client, hooks, prefetch helpers
│  │  ├─ store/                        # Zustand stores (one file per slice)
│  │  └─ upload/                       # Uppy instance, S3 plugin config
│  ├─ public/
│  ├─ styles/
│  ├─ tests/                           # Vitest + React Testing Library
│  ├─ next.config.ts
│  ├─ tailwind.config.ts
│  ├─ vitest.config.ts
│  ├─ tsconfig.json
│  └─ package.json
├─ src/
│  ├─ agents/
│  │  └─ my_agent/                     # single agent, fully co-located
│  │     ├─ prompt.md
│  │     ├─ agent.py
│  │     ├─ tools.py
│  │     └─ tests/
│  ├─ tools/                           # shared tool adapters + BaseTool interface
│  ├─ memory/
│  │  ├─ short_term/
│  │  └─ long_term/
│  ├─ state/                           # task state and checkpoints
│  ├─ schemas/                         # Pydantic / JSON schemas
│  ├─ policies/                        # safety rules, rate limits, approvals
│  ├─ models/                          # provider abstraction + cache
│  │  └─ cache/
│  ├─ observability/                   # logs, traces, metrics
│  ├─ evals/                           # prompt evals and scoring
│  └─ shared/                          # common utils
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
web/app/(auth)
web/app/(dashboard)
web/app/api/agent
web/app/api/uploads
web/components/ui
web/components/features
web/lib/query
web/lib/store
web/lib/upload
web/public
web/styles
web/tests
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
web/app/layout.tsx
web/app/page.tsx
web/next.config.ts
web/tailwind.config.ts
web/vitest.config.ts
web/tsconfig.json
web/package.json
web/lib/query/client.ts
web/lib/store/index.ts
web/lib/upload/uppy.ts
src/agents/my_agent/prompt.md
src/agents/my_agent/agent.py
src/agents/my_agent/tools.py
src/tools/base.py
```

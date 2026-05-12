# Agentic Repo Scaffolder

This repository provides blueprints and a utility script to quickly initialize the structure of an agentic project based on the project's scope and requirements.

## Overview

The project uses "situation" blueprints to define the filesystem structure and essential stub files for different scales of agent development:

- **Situation 01**: Solo Agent / Prototype / Short Scope (Minimum viable structure).
- **Situation 02**: Multi-agent / Medium Scope.
- **Situation 03**: Large / Enterprise Scope.

## Usage

Use the `scaffold.sh` script to create a project directory based on one of the blueprints:

```bash
./scaffold.sh <situation_file.md> [target_directory]
```

### Examples

- Create a prototype based on Situation 01:
  ```bash
  ./scaffold.sh situation01.md
  ```

- Create a medium-scope project in a specific directory:
  ```bash
  ./scaffold.sh situation02.md my-agent-project
  ```

## UI-less Blueprints

If you do not need a UI (e.g., for a headless agent or a CLI tool), use the blueprints located in the `without_ui/` directory:

```bash
./scaffold.sh without_ui/situation01.md my-headless-project
```

## Repository Structure

- `situation*.md`: Blueprints containing directory paths and stub files.
- `without_ui/`: UI-less versions of the blueprints.
- `scaffold.sh`: The script that parses blueprints and generates the filesystem.

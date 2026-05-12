# Agents Guide

This repository provides blueprints and a scaffolding script to quickly initialize agentic project structures.

## Developer Commands

### Scaffolding a Project
Use the `scaffold.sh` script to create a project structure based on a situation blueprint.

```bash
./scaffold.sh <situation_file.md> [target_directory]
```

- `<situation_file.md>`: Path to one of the blueprint files (e.g., `situation01.md`).
- `[target_directory]`: Optional. The directory to create. Defaults to the name of the situation file.

## Repository Structure

- `situation*.md`: Blueprints for different project scopes (Solo/Prototype, Multi-agent, Enterprise).
- `without_ui/`: Contains versions of the blueprints that omit UI-specific directories and files.
- `scaffold.sh`: The utility script that parses the `paths` and `stubs` blocks from blueprints to create the filesystem structure.

## Blueprint Definitions

- **Situation 01**: Solo Agent / Prototype / Short Scope.
- **Situation 02**: Multi-agent / Medium Scope.
- **Situation 03**: Large / Enterprise Scope.

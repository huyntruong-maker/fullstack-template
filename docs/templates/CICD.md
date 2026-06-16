# CI/CD — <PROJECT_NAME>

Owner agent: cicd-engineer.

## Pipelines (.github/workflows)
- ci.yml: build + test + lint (backend & frontend) on PR
- release.yml: build image, push to GHCR, create GitHub Release on tag

## Quality gates
Tests must pass, lint clean, coverage threshold, no vulnerable dependencies.

# Deployment — <PROJECT_NAME>

Owner agent: deploy-engineer.

## Artifacts
- API: multi-stage Dockerfile -> GHCR image
- Web: build static assets / container

## Environments
local (docker-compose) → staging → production.

## Operations
Health checks, config/secrets per environment, staged rollout, rollback procedure.

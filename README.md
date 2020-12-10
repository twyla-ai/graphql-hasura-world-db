# Hasura World Database Demo
[![Docker Repository on Quay.io](https://quay.io/repository/twyla-ai/hasura-world-db/status "Docker Repository on Quay.io")](https://quay.io/repository/twyla-ai/hasura-world-db)
[![](https://github.com/twyla-ai/hasura-world-db/workflows/Main/badge.svg)](https://github.com/twyla-ai/hasura-world-db/actions?query=workflow%3A%22Main%22)

A graphql interface using [hasura](https://hasura.io/) and postgres for the [MySQL world sample dataset](http://pgfoundry.org/frs/?group_id=1000150&release_id=366#world-world-1.0-title-content).

### Usage Examples
For hasura configuration options and usage, please refer to their wonderful documentation [here](https://docs.hasura.io/1.0/graphql/manual/index.html). 
In the following scenarios, the api and console will be available at `http://127.0.0.1:8080/`

- [Kubernetes Deployment](examples/kube-deployment.yaml)
- [Docker Compose](examples/docker-compose.yaml)
- [GitHub Action Workflow](examples/github-actions.yaml)
- [Circle CI](examples/circleci.yaml)

#### Podman

You can use the Kubernetes Deployment examples to start a pod with a postgres database and hasura.

```bash
podman play kube examples/kube-deployment.yaml
```

#### Docker

In this scenario, we assume that you already have a database running that can be reached from within the container.

```bash
# obviously secret is secret here and is not intended to be "secure" as this is a demo app
docker run --rm -it -p 8080:8080 \
    -e HASURA_GRAPHQL_DATABASE_URL="postgres://hasura:hasura@postgres-host-addr:5432/hasura" \
    -e HASURA_GRAPHQL_ENABLE_CONSOLE="true" \
    -e HASURA_GRAPHQL_ADMIN_SECRET="secret" \
    quay.io/twyla-ai/hasura-world-db:latest
```

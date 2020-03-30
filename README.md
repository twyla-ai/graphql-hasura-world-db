# Hasura World Database Demo
[![Docker Repository on Quay.io](https://quay.io/repository/twyla-ai/hasura-world-db/status "Docker Repository on Quay.io")](https://quay.io/repository/twyla-ai/hasura-world-db)
[![](https://github.com/twyla-ai/hasura-world-db/workflows/Main/badge.svg)](https://github.com/twyla-ai/hasura-world-db/actions?query=workflow%3A%22Main%22)

A graphql interface using [hasura](https://hasura.io/) and postgres for the [MySQL world sample dataset](http://pgfoundry.org/frs/?group_id=1000150&release_id=366#world-world-1.0-title-content).

### Usage Examples
For hasura configuration options and usage, please refer to their wonderful documentation [here](https://docs.hasura.io/1.0/graphql/manual/index.html). 
In the following scenarios, the api and console will be available at `http://127.0.0.1:8080/`

#### Docker CLI
In this scenario, we assume that you already have a database running that can be reached from within the container.
```bash
# obviously secret is secret here and is not intended to be "secure" as this is a demo app
docker run --rm -it -p 8080:8080 \
    -e HASURA_GRAPHQL_DATABASE_URL="postgres://hasura:hasura@postgres-host-addr:5432/hasura" \
    -e HASURA_GRAPHQL_ENABLE_CONSOLE="true" \
    -e HASURA_GRAPHQL_ADMIN_SECRET="secret" \
    quay.io/twyla-ai/hasura-world-db:latest
```
#### Docker Compose
You can run the application by using the following `docker-compose.yaml` can be used.
```yaml
version: '3.6'
services:
  postgres:
    image: postgres:9.6-alpine
    restart: on-failure
    environment:
      POSTGRES_PASSWORD: hasura
      POSTGRES_USER: hasura
      POSTGRES_DB: hasura

  hasura:
    image: quay.io/twyla-ai/hasura-world-db:latest
    ports:
      - 8080:8080
    depends_on:
      - postgres
    restart: on-failure
    environment:
      HASURA_GRAPHQL_DATABASE_URL: postgres://hasura:hasura@postgres:5432/hasura
      HASURA_GRAPHQL_ENABLE_CONSOLE: "true"
      HASURA_GRAPHQL_ADMIN_SECRET: secret
```
#### GitHub Action Service
This container can also be used as a [service container](https://help.github.com/en/actions/configuring-and-managing-workflows/about-service-containers) in your GitHub action job.
```yaml
jobs:
  job-id:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: docker.io/postgres:9.6-alpine
        env:
          POSTGRES_PASSWORD: hasura
          POSTGRES_USER: hasura
          POSTGRES_DB: hasura
        ports: 
          - 5432:5432
      hasura: 
        image: quay.io/twyla-ai/hasura-world-db:latest
        env:
          HASURA_GRAPHQL_DATABASE_URL: postgres://hasura:hasura@postgres:5432/hasura
          HASURA_GRAPHQL_ADMIN_SECRET: secret
        ports: 
          - 8080:8080
        options: --restart on-failure
    steps:
    - uses: actions/checkout@v1
    # you can also optionally wait for the service to be ready by adding this step
    - name: Wait for hasura
      run: |
        timeout 300s bash -c \
          'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' 127.0.0.1:${{ job.services.hasura.ports[8080] }}/healthz)" != "200" ]]; do sleep 5; done' \
        || false
```

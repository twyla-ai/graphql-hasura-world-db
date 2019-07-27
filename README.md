# Hasura World Database Demo
[![Docker Repository on Quay.io](https://quay.io/repository/twyla-ai/hasura-world-db/status "Docker Repository on Quay.io")](https://quay.io/repository/twyla-ai/hasura-world-db)

A graphql interface using [hasura](https://hasura.io/) and postgres for the [MySQL world sample dataset](http://pgfoundry.org/frs/?group_id=1000150&release_id=366#world-world-1.0-title-content).

### Usage Example
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

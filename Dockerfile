FROM hasura/graphql-engine:v1.3.1.cli-migrations

COPY hasura/migrations /hasura-migrations

FROM hasura/graphql-engine:v1.2.1.cli-migrations

COPY hasura/migrations /hasura-migrations

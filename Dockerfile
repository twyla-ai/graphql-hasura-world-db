FROM hasura/graphql-engine:v1.2.2.cli-migrations

COPY hasura/migrations /hasura-migrations

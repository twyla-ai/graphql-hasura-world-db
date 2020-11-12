FROM hasura/graphql-engine:v1.3.3.cli-migrations

COPY hasura/migrations /hasura-migrations

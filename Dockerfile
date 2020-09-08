FROM hasura/graphql-engine:v1.3.2.cli-migrations

COPY hasura/migrations /hasura-migrations

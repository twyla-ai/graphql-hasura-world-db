FROM hasura/graphql-engine:v1.2.0.cli-migrations

COPY hasura/migrations /hasura-migrations

FROM hasura/graphql-engine:v1.0.0.cli-migrations

COPY hasura/migrations /hasura-migrations

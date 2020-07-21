FROM hasura/graphql-engine:v1.3.0.cli-migrations

COPY hasura/migrations /hasura-migrations

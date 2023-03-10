FROM hasura/graphql-engine:v1.3.4.cli-migrations

COPY hasura/migrations /hasura-migrations

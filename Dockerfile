FROM hasura/graphql-engine:v1.0.0-beta.3.cli-migrations

COPY migrations /hasura-migrations

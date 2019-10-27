# BUILD
FROM elixir:1.9.2-alpine as build

RUN mix local.hex --force && \
    mix local.rebar --force

ENV MIX_ENV prod

WORKDIR /app

COPY . .

RUN mix deps.get && \
    mix release --quiet

# RELEASE
FROM alpine:3.9.2

RUN apk add --no-cache --update bash

WORKDIR /app

COPY --from=build /app/_build/prod/rel/greensync ./

CMD ["start"]
ENTRYPOINT ["/app/bin/greensync"]

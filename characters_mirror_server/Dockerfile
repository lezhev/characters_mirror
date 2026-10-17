# Build from the repository root:
# docker build -f characters_mirror_server/Dockerfile -t characters-mirror-server .
# The server depends on ../characters_mirror_shared, so the server directory alone
# is not a valid Docker build context.
FROM dart:3.13.5 AS build
WORKDIR /app

COPY characters_mirror_shared/ characters_mirror_shared/
COPY characters_mirror_server/ characters_mirror_server/

WORKDIR /app/characters_mirror_server
RUN dart pub get
RUN dart build cli --target bin/main.dart --output build

FROM dart:3.13.5
WORKDIR /app

ENV runmode=production \
    serverid=default \
    logging=normal \
    role=monolith

COPY --from=build /app/characters_mirror_server/build/bundle/ ./
COPY --from=build /app/characters_mirror_server/config/ ./config/
COPY --from=build /app/characters_mirror_server/web/ ./web/
COPY --from=build /app/characters_mirror_server/migrations/ ./migrations/
COPY --from=build /app/characters_mirror_server/lib/src/generated/protocol.yaml ./lib/src/generated/protocol.yaml

# Production secrets must be mounted/provided at runtime, never during image build.
EXPOSE 8080 8081 8082
ENTRYPOINT ["sh", "-c", "exec ./bin/main --mode=${runmode} --server-id=${serverid} --logging=${logging} --role=${role}"]

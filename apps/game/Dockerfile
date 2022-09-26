FROM node:16 as common
ARG BUILD_FLAG
ARG NODE_ENV
ENV NODE_ENV=$NODE_ENV
WORKDIR /app
RUN npm i -g nx
COPY . .
RUN npm install


FROM common as builder
RUN nx build game ${BUILD_FLAG}


FROM common as development
WORKDIR /app
ENV PORT=8080
CMD ["nx", "serve", "server"]


FROM common as test
WORKDIR /app
CMD ["nx", "test", "game"]


FROM caddy:latest as production
ENV NODE_ENV=$NODE_ENV
ENV PORT=8080
COPY --from=builder /app/builder/dist/apps/game /app/dist
COPY ./apps/game/Caddyfile /etc/caddy/Caddyfile
FROM node:16 as common
ARG NODE_ENV
ARG BUILD_FLAG
WORKDIR /app/builder
RUN npm i -g nx
COPY . .
RUN npm install


FROM common as builder
ARG NODE_ENV
ARG BUILD_FLAG
RUN nx build server ${BUILD_FLAG}


FROM node:16 as deps
WORKDIR /app/builder
ARG NODE_ENV
ARG BUILD_FLAG
COPY package.json package-lock.json .
RUN npm install --production


FROM common as development
WORKDIR /app
COPY --from=builder /app/builder ./
ENV NODE_ENV=$NODE_ENV
ENV PORT=8080
CMD ["nx", "serve", "server"]


FROM common as test
WORKDIR /app
COPY --from=builder /app/builder ./
ENV NODE_ENV=$NODE_ENV
CMD ["nx", "test", "server"]


FROM node:16 as production
WORKDIR /app
COPY --from=builder /app/builder/dist/apps/server ./dist/apps/server
COPY --from=deps /app/builder/node_modules ./node_modules
ENV NODE_ENV=$NODE_ENV
ENV PORT=8080
CMD ["node", "./dist/apps/server/main.js"]

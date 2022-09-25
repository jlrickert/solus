FROM node:16 as common
ENV NODE_ENV production
WORKDIR /app
RUN npm i -g nx
COPY package.json package-lock.json ./
RUN npm install


FROM common as base
COPY . .
COPY --from=common /app/node_modules /app/node_modules


FROM common as build
COPY --from=base . .
RUN nx run-many --target=build


FROM node:16
WORKDIR /app
CMD ["nx", "run-many", "--target=serve", "--configuration=production"]

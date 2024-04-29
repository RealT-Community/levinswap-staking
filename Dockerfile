# FROM node:14.21.3-alpine as BUILD
FROM node:16-alpine as BUILD

RUN apk update && apk add git python3 make g++

WORKDIR /app

COPY . .

RUN yarn install

RUN npm i -g expo-cli@latest

# Fix webpack polyfill
RUN yarn add stream-http

RUN expo build:web

# FROM node:16.15.0-alpine as SERVE
FROM node:16-alpine as SERVE

WORKDIR /app

COPY --from=BUILD /app/web-build/ /app

CMD ["npx", "serve", "-s"]

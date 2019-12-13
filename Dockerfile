FROM alpine:edge

RUN addgroup -S node && adduser -S node -G node

# upgrade and install build-essentials and python to later on build bcrypt and mongoose
RUN apk update && apk add --virtual build-dependencies build-base python gcc wget git && apk add nodejs npm

RUN mkdir /app && chown -R node:node /app

WORKDIR /app

COPY package*.json ./

USER node

COPY --chown=node:node . .

RUN npm install --verbose && npm run build

USER root

RUN apk del build-dependencies

USER node

EXPOSE 5300
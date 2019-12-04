FROM alpine:edge

RUN addgroup -S node && adduser -S node -G node

# upgrade and install build-essentials and python to later on build bcrypt and mongoose
RUN apk update && apk upgrade --progress && apk add --virtual build-dependencies build-base python gcc wget git nodejs npm

RUN mkdir /home/node/nodejs-kubernetes-api && chown -R node:node /home/node/nodejs-kubernetes-api

WORKDIR /home/node/nodejs-kubernetes-api

COPY package*.json ./

USER node

COPY --chown=node:node . .

RUN npm install --loglevel verbose && npm rebuild bcrypt --build-from-source && npm run build

# RUN apk del build-dependencies build-base python wget git

EXPOSE 5000

CMD [ "npm", "start", "--silent" ]
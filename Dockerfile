FROM node:14.20.0-alpine3.16 as base

FROM base as builder

WORKDIR /workspace

RUN apk add --update --no-cache \
    python3 \
    make \
    g++ \
    git \
    bash

COPY src /workspace/src
COPY package.json /workspace/package.json

RUN npm install --production

WORKDIR /home/node

COPY --from=builder /workspace/src /home/node/src
COPY --from=builder /workspace/node_modules /home/node/node_modules
COPY --from=builder /workspace/package.json /home/node/package.json
COPY --from=builder /workspace/package-lock.json /home/node/package-lock.json

# Application port
EXPOSE 8080

USER node

CMD npm run start
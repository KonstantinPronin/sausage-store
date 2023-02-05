FROM node:16-alpine3.17 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

FROM node:16-alpine3.17
WORKDIR /dist
COPY --from=builder /usr/src/app/dist /dist
RUN npm install -g http-server@latest
EXPOSE 80
ENTRYPOINT ["http-server", "/dist/frontend/", "-p", "80", "--proxy", "http://backend:8080"] 
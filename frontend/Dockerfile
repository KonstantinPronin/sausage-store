FROM node:16-alpine3.17 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

FROM nginxproxy/nginx-proxy:1.2
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html
COPY nginx.tmpl /app/nginx.tmpl

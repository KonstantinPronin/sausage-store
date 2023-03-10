FROM node:16-alpine3.17 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

FROM nginx:1.23-alpine
COPY --from=builder /usr/src/app/dist/frontend /usr/share/nginx/html
EXPOSE 8080 

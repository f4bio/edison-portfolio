FROM node:latest

WORKDIR /app
COPY . .

RUN npm ci
RUN npm run build

FROM nginx:mainline-alpine

LABEL Name="ACME Incorporated"
LABEL Author="Fabio Tea <iam@f4b.io>"
LABEL Version="1.0.12"

#COPY nginx_default.conf /etc/nginx/sites-enabled/default
COPY --from=0 /app/out /usr/share/nginx/html

RUN /bin/chown -R nginx:nginx /usr/share/nginx/html

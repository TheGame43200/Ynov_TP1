FROM nginx:latest
EXPOSE 80
COPY html /usr/share/nginx/html

FROM nginx:alpine
ARG VERSION=dev
COPY app/index.html /usr/share/nginx/html/index.html
RUN sed -i "s/__VERSION__/${VERSION}/g" /usr/share/nginx/html/index.html
EXPOSE 80

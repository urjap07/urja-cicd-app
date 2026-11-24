FROM nginx:alpine
LABEL maintainer="Urja Pipalia" prn="20240801001"
ARG BUILD_NO=0
COPY index.html /usr/share/nginx/html/index.html
RUN sed -i "s/BUILD_TAG/build-${BUILD_NO}/; s/BUILD_NO/${BUILD_NO}/" /usr/share/nginx/html/index.html
EXPOSE 80

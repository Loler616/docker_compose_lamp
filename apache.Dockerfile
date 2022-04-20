## [1] Obraz bazowy
FROM httpd:2.4.33-alpine
## [2] Inne składniki wymagane do działania aplikacji
RUN apk update; \
    apk upgrade;
COPY demo.apache.conf /usr/local/apache2/conf/demo.apache.conf
RUN echo "Include /usr/local/apache2/conf/demo.apache.conf" \
    >> /usr/local/apache2/conf/httpd.conf



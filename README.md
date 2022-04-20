# USŁUGA LAMP
_środowisko kontenerowe z wykorzystaniem narzędzia docker-compose_

![Docker compose logo](https://miro.medium.com/max/1000/1*JK4VDnsrF6YnAb2nyhMsdQ.png "Docker compose" )

# Baza projektu

Utworzony projekt to środowisko kontenerowe składające się z trzech usług składowych:
- serwera `Apache`,
- serwera `PHP`,
- bazy danych `MySQL`.
 
Wykorzystane zostały do tego obrazy utworzone na potrzeby projektu, zbudowane na podstawie plików `Dockerfile`.

# Zawartość plików tworzących szkielet projektu

Główna konfiguracja środowiska kontenerowego znalazła się w pliku `docker-compose.yml`, o poniższej treści:

```yaml
version: '3.7'
services:

  php:
    container_name: php
    build:
      dockerfile: php.Dockerfile
      context: .
    volumes:
      - ./html/:/var/www/html
    networks:
      - back
    depends_on:
      - mysql

  apache:
    build:
      dockerfile: apache.Dockerfile
      context: .
    ports:
      - 6666:80
    container_name: apache
    networks:
      - front
      - back

  mysql:
    build:
      dockerfile: mysql.Dockerfile
      context: .
    restart: always
    container_name: mysql
    environment:
      MYSQL_ROOT_PASSWORD: password123
    networks:
      - back

networks:
  front:
  back:
```

# Serwer Apache
Serwer utworzony został na podstawie pliku `Dockerfile` o poniższej treści:
```
## [1] Obraz bazowy
FROM httpd:2.4.33-alpine
## [2] Inne składniki wymagane do działania aplikacji
RUN apk update; \
    apk upgrade;
COPY demo.apache.conf /usr/local/apache2/conf/demo.apache.conf
RUN echo "Include /usr/local/apache2/conf/demo.apache.conf" \
    >> /usr/local/apache2/conf/httpd.conf
```
Jak widać, budowana usługa bazuje na zaktualizowanym obrazie `httpd:2.4.33-alpine`. Dołączany jest do niej także plik konfiguracyjny usługi `demo.apache.conf`, skopiowany z katalogu projektowego i dołączony do głównego pliku konfiguracyjnego `httpd.conf`.

Zgodnie z konfiguracją z pliku `docker-compose.yml`, port zewnętrzny (systemu macierzystego) otwarty na komunikację z serwerem to `6666`:
```yaml
ports:
      - 6666:80
```
Należy skonfigurować serwer Apache, aby przekierowywał zapytania o pliki PHP do kontenera `php`.
Zawartość pliku konfiguracyjnego Apache `demo.apache.conf`:
```
ServerName localhost

LoadModule deflate_module /usr/local/apache2/modules/mod_deflate.so
LoadModule proxy_module /usr/local/apache2/modules/mod_proxy.so
LoadModule proxy_fcgi_module /usr/local/apache2/modules/mod_proxy_fcgi.so

<VirtualHost *:80>
    # Proxy .php requests to port 9000 of the php-fpm container
    ProxyPassMatch ^/(.*\.php(/.*)?)$ fcgi://php:9000/var/www/html/$1
    DocumentRoot /var/www/html/
    <Directory /var/www/html/>
        DirectoryIndex index.php
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
    
    # Send apache logs to stdout and stderr
    CustomLog /proc/self/fd/1 common
    ErrorLog /proc/self/fd/2
</VirtualHost>
```

# Serwer PHP
Serwer utworzony został na podstawie pliku `Dockerfile` o poniższej treści:
```
## [1] Obraz bazowy
FROM php:7.4-fpm-alpine3.15
RUN apk update; \
    apk upgrade;
RUN docker-php-ext-install mysqli
```

Jak widać, serwer bazuje na obrazie `php:7.4-fpm-alpine3.15` pobranym z publicznego repozytorium. Dodatkowo, zainstalowane zostają aktualizacje oraz pakiet `mysqli` (obsługa bazy danych MySQL).

Serwer korzysta z woluminu zbindowanego z zasobem systemu macierzystego.
```yaml
    volumes:
      - ./html/:/var/www/html
```
Pozwala to m.in. na umieszczenie wstępnej zawartości udostępnianej przez serwer.
Utworzony został przykladowy plik `index.php`, pozwalający na przetestowanie działania utworzonego środowiska poprzez przeprowadzenie próby nawiązania połączenia z serwerem MySQL.
```php
<h1>Test połączenia z serwerem MySQL...</h1>

<?php 
	$host = 'mysql';
	$user = 'root';
	$pass = 'password123';
	$conn = new mysqli($host, $user, $pass);

	if ($conn->connect_error) {
		die("Nie udało się nawiązać połączenia. Errors: " . $conn->connect_error);
	} 
	else {
		echo "Udało się nawiązać połączenie!";
	}
?>
```

# Baza danych MySQL
Serwer, bazujący na oficjalnym obrazie `mysql:8.0.28`, utworzony został na podstawie pliku `Dockerfile` o poniższej treści:
```
## [1] Obraz bazowy
FROM mysql:8.0.28
```

W konfiguracji umieszczona została także zmienna środowiskowa, pozwalająca na zdefiniowane hasła domyślnego konta administracyjnego bazy danych `root`.
```yaml
environment:
      MYSQL_ROOT_PASSWORD: password123
```
Dla tworzonego środowiska skonteneryzowanej usługi LAMP, sensownym zabiegiem byłoby utworzenie zewnętrznego voluminu dla bazy danych. Podczas wykonywania prostego projektu laboratoryjnego, z powodu braku takiego wymogu, zostało to pominięte.

# Wdrożenie i przetestowanie rozwiązania

1. Instalacja [Docker Compose](https://docs.docker.com/compose/install/)
1. Utworzenie plików `docker-compose.yml` oraz plików `Dockerfile` dla usług składowych.
1. Utworzenie pliku konfiguracyjnego dla serwera Apache `demo.apache.conf`.
1. Utworzenie odpowiedniej struktury katalogów
    1. umieszczenie wszystkich plików `Dockerfile`, pliku `demo.apache.conf` oraz pliku `docker-compose.yml` w głównym katalogu projektu;
    2. utworzenie podkatalogu o nazwie `html` oraz umieszczenie w nim pliku `index.php`.
1. Zbudowanie i ruchomienie wszystkich kontenerów poleceniem `docker-compose up`.
1. Weryfikacja poprawności zbudowania środowiska np. poprzez próbę połączenia przez przeglądarkę WWW z serwerem utworzonej usługi WWW poprzez adres `localhost:6666`.

# Reprezentacja graficzna dla utworzonego pliku

Stworzenie reprezentacji graficznej możliwe jest za pomocą wykonania w katalogu projektowym następującego polecenia:
```
 docker container run --rm -it --name dcv -v $(pwd):/input pmsipilot/docker-compose-viz render -m image docker-compose.yml
```

![reprezentacja graficzna](https://drive.google.com/uc?id=1pwRSqs4iOBFnLZ4yDI3iDHyxQIPZ5KGX)

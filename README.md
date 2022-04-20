# USŁUGA LAMP
_środowisko kontenerowe z wykorzystaniem narzędzia docker-compose_


![Docker compose logo](data:image/png;base64,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 "Docker compose" )








# Baza projektu

Utworzony projekt to środowisko kontenerowe składające się z trzech usług składowych:
- serwera `Apache`,
- serwera `PHP`,
- bazy danych `MySQL`.
 
Wykorzystane zostały do tego obrazy utworzone na potrzeby projektu, zbudowane na podstawie plików `Dockerfile`.

# Zawartość plików tworzących szkielet projektu

Główna konfiguracja środowiska kontenerowego znalazła się w pliku `docker-compose.yml`, o ponizszej treści.

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
Serwer utworzony został na podstawie pliku `Dockerfile` o poniższej treści.
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

# Serwer PHP
Serwer utworzony został na podstawie pliku `Dockerfile` o poniższej treści.
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
Serwer, bazujący na oficjalnym obrazie `mysql:8.0.28`, utworzony został na podstawie pliku `Dockerfile` o poniższej treści.
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

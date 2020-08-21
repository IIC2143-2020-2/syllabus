# Manual de Instalación

## Paso Número 1

- Para aquellos que estén utilizando Windows, tendrán que descargar WSL. Pueden usar [esta guía](https://docs.microsoft.com/en-us/windows/wsl/install-win10). De ahora en adelante, al referirnos a "la consola" o "el terminal", aquellos utilizando Windows deben utilizar la consola de WSL.

## Paso Número 2

- Instalar las dependencias necesarias. Para eso, desde la consola se deben ejecutar los siguientes comandos:

```bash
sudo apt-get update
sudo apt-get install build-essential patch liblzma-dev libpq-dev
```

## Paso Número 3

- Instalar _Ruby Version Manager_, también conocido como _rvm_. Para eso, ejecutar los siguientes comandos desde la consola:

```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
```

Con el primer comando, instalamos una llave que se utiliza (_automágicamente_) para verificar el paquete a instalar. Con el segundo comando instalamos _rvm_.

## Paso Número 4

- Instalar PostgreSQL en tu máquina. Para eso, ejecutaremos el siguiente comando:

```bash
sudo apt-get install postgresql postgresql-contrib
```

## Paso Número 5

- Instalar Ruby 2.6 o 2.7 e instalar Ruby on Rails 5.2.4

```bash
rvm install 2.6
gem install rails -v 5.2.4
```

## Paso Número 6

- Ahora tenemos que instalar Node (un [_runetime_](https://en.wikipedia.org/wiki/Runtime_library) de JavaScript), para lo que utilizaremos _Node Version Manager_ o _nvm_ (las versiones más recientes de RoR necesitan Node).

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install --lts
```

Si por alguna razón tienes un problema con este paso, cierra la consola y vuelve a intentarlo en una consola nueva.

## Paso Número 7

- Ahora lo último antes de iniciar el proyecto! Debemos setear una contraseña para nuestro usuario `postgres`.

1) Primero ingresamos a la consola de PostgreSQL como usuario `postgres`:

    ```bash
    sudo -u postgres psql
    ```

2) Luego, le agregamos una contraseña al usuario `postgres`. Asegúrate de usar la misma contraseña que tu equipo para que no hayan problemas más tarde:

    ```bash
    \password
    ```

    Ingresa la contraseña en el _prompt_.

## Paso Número 8

- Ya tenemos todo para iniciar nuestro proyecto. Para esto, dirígete a la consola y ejecuta el siguiente comando:

```bash
rails new <nombre proyecto> --database=postgresql
```

- Ahora nos movemos a nuestra carpeta del proyecto con:

```bash
cd <nombre proyecto>
```

- Y por último, corremos el siguiente comando que instalará sus dependencias del proyecto:

```bash
bundle install
```

## Paso Número 9

- Ahora que ya tenemos los archivos del proyecto, necesitamos setear la configuración de la base de datos que ocuparemos. Dirígete dentro de tu proyecto a `config/database.yml` y reemplaza su contenido con lo siguiente:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  host: localhost
  username: postgres
  password: <la clave que pusiste en el paso 7>
  pool: 5

production:
  <<: *default
  database: <nombre de tu app>_production

development:
  <<: *default
  database: <nombre de tu app>_development

test:
  <<: *default
  database: <nombre de tu app>_test
```

## Paso Número 10

- Ahora que ya tenemos todo instalado y configurado, debemos iniciar un servidor de PostgreSQL. Para eso, ejecuta el siguiente comando:

```bash
sudo service postgresql start
```

Tendrás que ejecutar este comando cada vez que prendas tu máquina.

## Paso Número 11

- Necesitamos una base de datos para tu app! El siguiente comando creará una por ti:

```bash
rails db:create
```

## Paso Número 12

- Ahora utilizando tu consola, corre el servidor del proyecto con el siguiente comando:

```
rails server
```

- Ahora que tienes el servidor corriendo, dirígete a http://localhost:3000/ y debería aparecernos el mensaje _Yay! You’re on Rails!_

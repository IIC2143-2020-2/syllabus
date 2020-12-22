# ¿Cómo puedo quedarme con mi proyecto?

En esta _guía rápida_, aprenderás a cómo quedarte con tu proyecto luego del ramo (por si quieres seguirlo mejorando y aprendiendo o si simplemente te gustaría mantener lo que construiste a lo largo del semestre en un repositorio bajo tu cuenta personal de GitHub). Háblalo con tu grupo para decidir qué hacer con esta información (pueden usar [una organización de GitHub](https://docs.github.com/en/github/setting-up-and-managing-organizations-and-teams/about-organizations) para que todos sean "dueños" del repositorio con los mismos pasos que hay en esta guía). Los pasos son los siguientes:

1. Entra a la carpeta en que está tu repositorio en tu máquina a través de tu consola

    ```sh
    $ cd ~/path/to/repository/grupo0-proyecto
    ```

2. Asegúrate de que tu repositorio está actualizado

    ```sh
    $ git checkout master
    $ git pull

    $ git checkout develop
    $ git pull
    ```

    Repite eso para todas las ramas que tengas

3. Crea un nuevo repositorio de GitHub donde quieras que quede almacenado el proyecto. En mi caso, mi repositorio se llamará `proyecto-software`, por lo que la URL hasta mi repositorio será `https://github.com/daleal/proyecto-software.git`. Puedes darle una descripción al proyecto opcionalmente al momento de crearlo. Además, puedes marcarlo como público o privado. **Asegúrate de inicializar el repositorio vacío**. Esto quiere decir que los cuadros que dicen "_Add a README file_", "_Add .gitignore_" y "_Choose a license_" **no deben estar marcados**. Una vez finalizado esto, puedes crear el repositorio. El repositorio debería estar vacío, y deberías ver los siguientes títulos a lo largo de la página:

    - **Quick setup — if you’ve done this kind of thing before**
    - **…or create a new repository on the command line**
    - **…or push an existing repository from the command line**
    - **…or import code from another repository**

4. Ahora, vuelve a tu consola y ejecuta el siguiente comando:

    ```sh
    $ git remote add clone https://github.com/daleal/proyecto-software.git
    ```

    Este comando agrega un _remote_ llamado `clone` a tu repositorio de `git` en la URL del repositorio remoto que desees. En mi caso, deseo hacer el nuevo _remote_ en `https://github.com/daleal/proyecto-software.git`. Si quieres aprender más sobre _remotes_, te recomiendo leer [la documentación de git](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes). Ahora deberías poder ver el nuevo _remote_ agregado a tu repositorio local

    ```sh
    $ git remote -v

    clone	https://github.com/daleal/proyecto-software.git (fetch)
    clone	https://github.com/daleal/proyecto-software.git (push)
    origin	https://github.com/IIC2143-2020-2/grupo0-proyecto.git (fetch)
    origin	https://github.com/IIC2143-2020-2/grupo0-proyecto.git (push)
    ```

5. Haz `push` de tu repositorio al nuevo _remote_!

    ```sh
    $ git push clone --all
    ```

    Con ese comando, se hará `push` de todas las _branches_ de tu repositorio local al nuevo _remote_! Ahora solo debes actualizar la página en GitHub y verás que tu repositorio contendrá todo el código junto con todos los _commits_! Si deseas hacer `push` de solamente algunas _branches_, puedes ejecutar el siguiente comando en vez del anterior:

    ```sh
    $ git push clone <branch-name>
    ```

6. Elimina de tu máquina el proyecto y hazle `pull` desde tu nuevo repositorio! Puedes hacerlo de la siguiente manera (recuerda que nuestra consola está en la raíz de nuestro repositorio local):

    ```sh
    # Salir del repositorio y eliminarlo
    $ cd ..
    $ rm -rf grupo0-proyecto

    # Clonar el repositorio desde el nuevo remote
    $ git clone https://github.com/daleal/proyecto-software.git
    $ cd proyecto-software
    ```

    Ahora ya puedes seguir trabajando en tu proyecto actualizando los cambios en el nuevo repositorio en vez del antigo!

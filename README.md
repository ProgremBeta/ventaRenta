# Proyecto Venta Renta

## Introduccion

Este es un repositorio monolitico(tiene backend y frontend juntos) usando una estructura de carpetas modular y por capas.

## Instalar proyecto completo 

hacer un git clone del proyecto:

    git clone https://github.com/ProgremBeta/ventaRenta
    cd ventaRenta

seguir las siguientes instrucciones:

### BACKEND

Estando en la raiz del proyecto navegar hasta el backend:

    ce backend

En necesario que tenga instalado Node JS https://nodejs.org/en y NPM, en windows al instalar desde la pagina oficial viene incluido el npm con el node js, para verificar la instalacion ejecutar el siguiente comando:

``` bash
  node -v
  npm -v
```

En algunas distribuciones de linux se tiene que instalar el npm aparte, tendrian que buscarlo en su gestor de paquete he instalarlo, en mi caso uso arch entonces los comandos serian:


    sudo pacman -S nodejs
    sudo pacman -S npm

y vuelve a verificar la instalacion.

### Paquetes usados en el backend

  * bcrypt
  * cors
  * dotenv
  * express
  * jsonwebtoken
  * pg

### Comando de instalacion

para instalar estos paquetes simplemente se usa el comando:

    npm install

### ejecucion del proyectos

El proyecto actualmente esta en desarrollo y para ejecutarlo con autorefresco:

    npm run dev

>[!NOTE]
> para que no tenga ningun inconventiente tiene que estar ubicado en la raiz del proyecto backend

### FRONTEND

Estando en la raiz del proyecto navegar hasta el frontend:

    cd frontend

el frontend esta siendo desarrollado en flutter entonces para ejecutar el proyectos en necesario lo siguiente:

>[!NOTE]
> Depende del sistema operativo al instalar el flutter todo viene integrado y otros es necesario instarlar estos paquetes manualmente.

  * instalar flutter https://docs.flutter.dev/install 
  * instalar cmake https://cmake.org/download/
  * instalar ninja https://pub.dev/packages/ninja/versions

### Ejecutar frontend

ya teniendo todos los paquetes de flutter tambien se puden comprobar que este correcto con el comando:

    flutter doctor
  
y para ejecutar el proyecto el comando:

  flutter run

### base de datos

La base de datos que use fue POSTGRESQL y esta ubicada en database, desde la raiz del proyecto ingresar el comando:

    cd backend/src/database

ahi estan las diferentes versiones de la base de datos

  * schema_V1.sql
  * schema_V2.sql










### Notas de desarrollo

>[!WARNING]
> Estas notas de desarrollo estan para tener encuenta los cosas que me falta implementar o cosas que me resultaron utiles en el desarrollo, dicho esto, este apartado se eliminara o va ir cambiendo deacuerdo al desarrollo o al finalizarlo el mismo.

  * la mayoria de request necesitan condicionales pues muestran errores generales y quiero que el usuario sepa en que esta equivocado y corregir la falla o saber si fue un problema de entrada de datos o del sistema.

  * al intentar crear algunos valores a la base de datos no deja, por que se declaro cuando se creo la base de datos como valores en las tablas que dependen de otros valores de otras tablas o que estan limitados hasta cierta cantidad de caracteres. Entonces voy a cambiar en algunos valores de algunas tablas el limite de caracteres permitidos.

  *entonces hay que tener en cuenta que cuando sale un valor null o salga con errores de "tipo de datos incorrectos" mayormente se debe a la cantidad de caracteres permitidos

  * en el backend hay un archivo PruebasREST.http que la uso con la extension en visual studio code https://marketplace.visualstudio.com/items?itemName=humao.rest-client para hacer las pruebas rapidas.

  * la estructura de la base de datos hace falta actualizar algunos casos para se adecuen al proposito del programa, tener mas control y mejorar los registros.

  * en shared esta el archivo de transicion que es para evitar errores al hacer las peticiones, en si entra en un estado de transicion que inicia con BEGIN, si no hay errores hace el COMMIT y si hay algun fallo hacer un ROCKBALL que revierte los cambios hechos durante ese estado. Esto no esta completamente implementado ya que con las condicionales no han habido mayores problemas pero de igual forma lo quiero implementar para tener mas seguridad y no tener fallos.

  * uufff el abrir el visual con los 2 repositorios el del backend y frontend que es un repo monolib parece que se va estallar mi pc

  * unos de los cambios drastricos en la base de datos va ser en rentas, renta_dispositivos, dispositivos ya que no tiene un flujo correcto y me equivoque al asignarlos para que tenga un coerenci entre el nombre y su proposito. De momento tengo pensado en hacer cambios a :
    * renta
    * renta_dispositivos

  * la tabla de usuarios necesita una columna que sea de ID o cambiarlo para que al ingresar el usuario el identificador sea un numero que vaya aumentando, si no, con el numero de identificacion para que funcione el login, de momento voy hacer el login con el numero de identificacion para cuando realize la restructuracion de la base de datos no cambie la logica.

  * estaba tratando de manejar esta estructura de carpetas de una forma que pense que estaba correcto pero me di cuenta de que no la supe manejar o no la entendi, entonces voy hacer otro gran cambio ya que lo que estaba haciendo ya me parecia enredando, los archivos que estaba haciendo y la gran parte de los endpoints no los voy a usar, entonces estoy optando por dejar solo lo que se necesita y se va a usar.
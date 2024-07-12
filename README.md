# Gymnastic Center

<img src="https://i.ibb.co/2gvV6Vv/gymnastic-logo.jpg" alt="Gymnastic Center Logo" width="200"/>

## Descripción

Gymnastic Center es una aplicación móvil desarrollada en Flutter que permite a los usuarios acceder a cursos de ejercicios y deportes, con lecciones guiadas por entrenadores profesionales. Los usuarios pueden realizar un seguimiento de su progreso en los cursos, acceder a blogs sobre diversos tópicos de deportes y ejercicios, y dejar comentarios en ellos.

## Arquitectura

La aplicación está construida utilizando una arquitectura hexagonal, dividida en las siguientes capas:

### Capa de Infraestructura

- **Vistas**: Implementación de la interfaz de usuario.
- **Repositorios**: Implementaciones de los repositorios.
- **Implementaciones adicionales**: Incluye el almacenamiento local utilizando `shared_preferences`, entre otros.

### Capa de Aplicación

- **BLoC**: Gestión del estado de la aplicación utilizando el patrón BLoC.
- **Casos de Uso**: Definición de los eventos y acciones que se pueden ejecutar en la aplicación.

### Capa de Dominio

- **Entidades de Dominio**: Definición de las entidades principales del negocio.
- **Contratos de Repositorios**: Interfaces de los repositorios que definen las operaciones disponibles.

## Funcionalidades

- **Cursos y Lecciones**: Acceso a cursos de ejercicios y deportes con lecciones guiadas por entrenadores.
- **Seguimiento de Progreso**: Visualización del progreso en los cursos basado en las lecciones completadas.
- **Videos de Lecciones**: Cada lección incluye su respectivo video.
- **Blogs**: Acceso a blogs sobre diversos temas de deportes y ejercicios.
- **Comentarios**: Posibilidad de dejar comentarios en los blogs.

## Desarrolladores

- Jesús Pérez
- Miguel Arria
- Bryant Mitchell
- Víctor Madera
- Christopher Rojas
- Leonardo Richard
- Gianpiaro Yorlano
- Víctor Pabón

## Dependencias

- [Flutter BLoC](https://pub.dev/packages/flutter_bloc)
- [Shared Preferences Flutter](https://pub.dev/packages/shared_preferences)
- [Dio](https://pub.dev/packages/dio)
- [Media Player](https://pub.dev/packages/video_player) 

## Instalación

1. Clona el repositorio:
   ```
   git clone <URL_DEL_REPOSITORIO>
   cd gymnastic-center
   ```
2. Instala las dependencias:
    ```
    flutter pub get
   ```
4. Corre la aplicación:
    ```
    flutter pub run
   ```

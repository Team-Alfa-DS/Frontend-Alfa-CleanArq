abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NoSessionFailure extends Failure {
  const NoSessionFailure({String message = 'No existe una sesión iniciada'})
      : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure(
      {String message =
          'Estamos experimentando ciertos problemas. Inténtalo de nuevo más tarde'})
      : super(message);
}

class NoAuthorizeFailure extends Failure {
  const NoAuthorizeFailure({required String message}) : super(message);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({String message = 'No conexion a internet'})
      : super(message);
}

class UnnableToCheckLocationFailure extends Failure {
  const UnnableToCheckLocationFailure({required String message})
      : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super('Oppss!! Algo salió mal, inténtalo de nuevo');
}

class CreateVideoFailure extends Failure {
  const CreateVideoFailure(
      {String message =
          'Hubo un error creando el video. Inténtalo de nuevo más tarde'})
      : super(message);
}

class VideoNotFoundFailure extends Failure {
  const VideoNotFoundFailure(
      {String message = 'No se pudo encontrar el video, vuelve a intentarlo'})
      : super(message);
}

class GetVideoFailure extends Failure {
  const GetVideoFailure({String message = 'Error obteniendo los videos'})
      : super(message);
}

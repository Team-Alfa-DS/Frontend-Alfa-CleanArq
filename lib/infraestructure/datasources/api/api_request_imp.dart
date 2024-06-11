import 'package:dio/dio.dart';
import '../../../common/failure.dart';
import '../../../common/result.dart';
import 'api_request.dart';

class ApiRequestManagerImpl extends IApiRequestManager {
  final Dio _dio;

  ApiRequestManagerImpl({
    required super.baseUrl,
  }) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  Future<Result<T>> request<T>(
      String path, String method, T Function(dynamic) mapper,
      {dynamic body, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.request(path,
          data: body,
          options: Options(method: method),
          queryParameters: queryParameters);
      return Result<T>(value: mapper(response.data));
    } on DioError catch (e) {
      // Corrected DioException to DioError
      return Result(failure: handleException(e));
    } catch (e) {
      return Result(failure: const UnknownFailure());
    }
  }

  Failure handleException(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return const NoInternetFailure();
      case DioErrorType.response:
        return NoAuthorizeFailure(message: e.response?.data['message']);
      case DioErrorType.other:
        if (e.message.contains('SocketException')) {
          return const NoInternetFailure();
        }
        return const UnknownFailure();
      default:
        return const UnknownFailure();
    }
  }

  @override
  void setHeaders(String key, dynamic value) =>
      _dio.options.headers[key] = value;
}

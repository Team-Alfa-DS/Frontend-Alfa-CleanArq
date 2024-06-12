import 'package:alpha_gymnastic_center/common/result.dart';

abstract class IApiRequestManager {
  final String baseUrl;
  IApiRequestManager({required this.baseUrl});

  Future<Result<T>> request<T>(
      String path, String method, T Function(dynamic) mapper,
      {dynamic body, Map<String, dynamic>? queryParameters});
  void setHeaders(String key, dynamic value);
}

import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

class CreateProgressProfileRequestMapper {
  static Map<String, dynamic> toJson(
      CreateProgressProfileRequest profileRequest) {
    return {
      'user': profileRequest.user,
      'percent': profileRequest.percent,
      'time': profileRequest.time,
    };
  }
}

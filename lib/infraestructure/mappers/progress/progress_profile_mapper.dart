import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

class CreateProgressProfileRequestMapper {
  static Map<String, dynamic> toJson(
      CreateProgressProfileRequest profileRequest) {
    return {
      'percent': profileRequest.percent,
      'time': profileRequest.time,
    };
  }
}

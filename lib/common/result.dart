import 'package:alpha_gymnastic_center/common/failure.dart';

class Result<T> {
  late final T? value;
  late final Failure? failure;
  late final String? statusCode;

  Result({T? value, Failure? failure, String? statusCode}) {
    if (value == null && failure != null) {
      this.failure = failure;
      this.value = null;
    } else if (value != null && failure == null) {
      this.value = value;
      this.failure = null;
    } else if (value == null && failure == null && statusCode != null) {
      this.value = null;
      this.statusCode = statusCode;
      this.failure = null;
    } else {
      throw ArgumentError(
          'Result cannot have a null value and a null failure at the same time');
    }
  }

  bool hasValue() {
    return value != null;
  }
}

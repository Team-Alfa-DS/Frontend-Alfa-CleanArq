import 'package:alpha_gymnastic_center/domain/interfaces/progress_interfaces.dart';

class PostProgressMapper {
  static Map<String, dynamic> toJson(PostProgress postProgress) {
    return {
      'courseId': postProgress.courseId,
      'markAsComplete': postProgress.markAsComplete,
      'lessonId': postProgress.lessonId,
      'time': postProgress.time,
    };
  }
}

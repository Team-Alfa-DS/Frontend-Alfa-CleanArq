import 'package:alpha_gymnastic_center/domain/entities/lesson.dart';

class LessonMapper {
  static Lesson fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      video: json['video'],
      image: json['image']
    );
  }

  static Map<String, dynamic> toJson(Lesson lesson) {
    return {
      'id': lesson.id,
      'title': lesson.title,
      'content': lesson.content,
      'video': lesson.video,
      'image': lesson.image
    };
  }
}

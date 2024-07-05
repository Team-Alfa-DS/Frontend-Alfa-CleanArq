import 'dart:convert';
import 'package:alpha_gymnastic_center/domain/entities/video.dart';

class VideoMapper {
  static Video fromJson(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Video(
      id: jsonMap['id'] as String,
      title: jsonMap['title'] as String,
      url: jsonMap['url'] as String,
      duration: jsonMap['duration'] as int,
      idLesson: jsonMap['idLesson'] ?? '',
    );
  }

  static String toJson(Video video) {
    final Map<String, dynamic> jsonMap = {
      'id': video.id,
      'title': video.title,
      'url': video.url,
      'duration': video.duration,
      'idLesson': video.idLesson,
    };
    return json.encode(jsonMap);
  }
}

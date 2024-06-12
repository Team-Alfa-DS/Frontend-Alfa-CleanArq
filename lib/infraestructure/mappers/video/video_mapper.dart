import 'package:alpha_gymnastic_center/domain/entities/video.dart';

class VideoMapper {
  static Video fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      duration: json['duration'],
      idLesson: json['idLesson'],
    );
  }

  static Map<String, dynamic> toJson(Video video) {
    return {
      'id': video.id,
      'title': video.title,
      'url': video.url,
      'duration': video.duration,
      'idLesson': video.idLesson,
    };
  }
}

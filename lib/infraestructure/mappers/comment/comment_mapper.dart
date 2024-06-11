import '../../../domain/entities/comment.dart';

class CommentMapper {
  static comment fromJson(Map<String, dynamic> json) {
    return comment(
        date: json['date'],
        id: json['id'],
        target: json['target'],
        token: json['token'],
        user: json['user'],
    );
  }

  static Map<String, dynamic> toJson(comment comment) {
    return {

    };
  }
}
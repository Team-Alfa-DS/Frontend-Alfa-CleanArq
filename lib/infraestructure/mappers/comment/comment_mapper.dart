import '../../../domain/entities/comment.dart';

class CommentMapper {
  static Comment_ fromJson(Map<String, dynamic> json) {
    return Comment_(
      id: json['id'] ?? '',
      user: json['user'] ?? '',
      body: json['body'] ?? '',
      countDislikes: json['countDislikes'] ?? 0,
      countLikes: json['countLikes'] ?? 0,
      userLiked: json['userLiked'] ?? false,
      userDisliked: json['userDisliked'] ?? false,
      date: json['date'] ?? '',
      targetType: json['targetType'] ?? '',
    );
  }

  static Map<String, dynamic> toJson(Comment_ comment) {
    return {
      'target': comment.targetId,
      'targetType': comment.targetType,
      'body': comment.body
    };
  }
}
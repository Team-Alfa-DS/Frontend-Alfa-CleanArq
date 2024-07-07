import '../entities/comment.dart';

class CommentRequest{
    String id;
    String user;
    int? countLikes;
    int? countDislikes;
    String body;
    bool? userLiked;
    bool? userDisliked;
    String? date;

    CommentRequest({
        required this.id,
        required this.user,
        this.countLikes,
        this.countDislikes,
        required this.body,
        this.userLiked,
        this.userDisliked,
        this.date,
    });

}
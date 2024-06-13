import '../entities/comment.dart';

class ManyCommentsRequest {
    String token;
    QueryComment query;
    String id;
    String user;
    int? countlikes;
    int? countdislikes;
    DateTime date;

    ManyCommentsRequest({
        required this.token,
        required this.date,
        required this.countdislikes,
        required this.countlikes,
        required this.id,
        required this.query,
        required this.user
    });

}

class SingleComment {

    String token;
    String target;
    targetType targettype;
    String body;
    SingleComment({
        required this.token,
        required this.target,
        required this.targettype,
        required this.body,
    });

}
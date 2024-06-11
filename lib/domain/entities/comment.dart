enum targetType { lesson, blog }

class QueryComment {
  int page;
  int perpage;
  String? blogid;
  String? lessonid;

  QueryComment({
    required this.page,
    required this.perpage,
    required this.blogid,
    required this.lessonid
  });
}

class comment{
    String token;
    String id;
    String user;
    int? countlikes;
    int? countdislikes;
    DateTime date;
    targetType target;

    comment({
      required this.token,
      required this.id,
      required this.user,
      this.countlikes,
      this.countdislikes,
      required this.date,
      required this.target
    });

}
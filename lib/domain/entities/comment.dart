class Comment_{
    String? id;
    String? user;
    int? countLikes;
    int? countDislikes;
    String body;
    bool? userLiked;
    bool? userDisliked;
    String? date;
    String? targetType;
    String? targetId;

    Comment_({
      this.id,
      this.user,
      this.countLikes,
      this.countDislikes,
      required this.body,
      this.userLiked,
      this.userDisliked,
      this.date,
      this.targetType,
      this.targetId,
    });

}
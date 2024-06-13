class Lesson {
  String id;
  String title;
  String content;
  String? video;
  String? image;
  Lesson({
    required this.id,
    required this.title,
    required this.content,
    this.video,
    this.image,
  });
}

class CreateLessonRequest {
  final String title;
  final String content;
  final String? video;
  final String? image;

  CreateLessonRequest({
    required this.title,
    required this.content,
    this.video,
    this.image,
  });
}

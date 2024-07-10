class Video {
  final String id;
  final String url;
  final String idLesson;
  final String? title;
  final int? duration;
  final int? progress;

  Video({
    required this.id,
    required this.url,
    required this.idLesson,
    this.title,
    this.duration,
    this.progress,
  });
}

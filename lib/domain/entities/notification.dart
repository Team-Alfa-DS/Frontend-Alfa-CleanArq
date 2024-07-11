class Notifications {
  String id;
  String title;
  String body;
  DateTime date;
  bool? readed;
  num? count;

  Notifications({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.readed,
    this.count,
  });
}

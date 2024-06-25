class Notification {
  String id;
  String title;
  String body;
  DateTime date;
  bool? userReaded;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    this.userReaded,
  });
}

class Notifications {
  String id;
  String title;
  String body;
  DateTime date;
  bool userReaded;

  Notifications({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.userReaded,
  });
}

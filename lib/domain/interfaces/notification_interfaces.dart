class CreateNotificationRequest {
  final String title;
  final String body;
  final DateTime date;
  final bool userReaded;

  CreateNotificationRequest({
    required this.title,
    required this.body,
    required this.date,
    required this.userReaded,
  });
}

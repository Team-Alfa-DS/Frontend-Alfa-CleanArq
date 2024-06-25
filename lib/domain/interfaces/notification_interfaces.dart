class CreateNotificationRequest {
  final String id;
  final String title;
  final String body;
  final DateTime date;

  CreateNotificationRequest({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });
}

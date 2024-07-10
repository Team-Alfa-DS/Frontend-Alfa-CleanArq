import 'package:intl/intl.dart';

String formatLastSeen(DateTime lastTime) {
  final now = DateTime.now();
  final difference = now.difference(lastTime);

  if (difference.inMinutes < 60) {
    return 'hace ${difference.inMinutes} minutos';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return 'hace $hours ${hours == 1 ? 'hora' : 'horas'}';
  } else if (difference.inDays == 1) {
    return 'ayer';
  } else {
    return DateFormat('dd/MM/yy').format(lastTime);
  }
}

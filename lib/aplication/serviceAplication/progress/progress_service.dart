import 'package:alpha_gymnastic_center/domain/entities/progress.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProgressService {
  final String baseUrl = dotenv.env['API_URL'] ?? 'http://default-url.com';

  Future<void> saveProgress({
    required String courseId,
    required String lessonId,
    required bool markAsCompleted,
    int? time,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/progress/mark/end'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'courseId': courseId,
        'lessonId': lessonId,
        'markAsCompleted': markAsCompleted,
        'Time': time,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save progress');
    }
  }

  Future<int?> getProgress(String courseId, String lessonId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/progress/one/$courseId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final lesson = data['Lessons'].firstWhere(
        (lesson) => lesson['lessonId'] == lessonId,
        orElse: () => null,
      );
      return lesson?['Time'];
    } else {
      throw Exception('Failed to load progress');
    }
  }

  Future<ProgressProfile> getProgressProfile(
      String baseUrl, String token) async {
    final url = Uri.parse('$baseUrl/progress/profile');

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final percent = data['Percent'] as double;
      final time = data['Time'] as int;
      return ProgressProfile(percent: percent, time: time);
    } else {
      throw Exception('Failed to load progress: ${response.statusCode}');
    }
  }
}

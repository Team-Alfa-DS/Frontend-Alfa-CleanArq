import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class ProgressProfile {
  String? id;
  User? user;
  num? percent;
  int? time;

  ProgressProfile({this.id, this.user, this.percent, this.time});
}

class ProgressCourse {
  String? id;
  User? user;
  List<Course>? courses;
  num? percent;
  int? time;
  bool? markAsComplete;

  ProgressCourse(
      {this.id,
      this.user,
      this.courses,
      this.percent,
      this.time,
      this.markAsComplete});
}

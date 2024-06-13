import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class Progress {
  String? id;
  User? user;
  List<Course>? courses;
  num? percent;
  int? time;
  bool? markAsComplete;
  String? lessonid;
  String? lastTime;
  Course? course;


  Progress({
      this.id,
      this.user,
      this.courses,
      this.percent,
      this.time,
      this.markAsComplete,
      this.lessonid,
      this.lastTime,
      this.course,
  });
}

import 'package:alpha_gymnastic_center/domain/entities/course.dart';
import 'package:alpha_gymnastic_center/domain/entities/user.dart';

import 'lesson.dart';


class Progress {
  String? id;
  User? user;
  List<Course>? courses;
  List<Lesson>? lessons;
  num? percent;
  int? time;
  bool? markAsComplete;



  Progress({
    this.id,
    this.user,
    this.courses,
    this.lessons,
    this.percent,
    this.time,
    this.markAsComplete});
}

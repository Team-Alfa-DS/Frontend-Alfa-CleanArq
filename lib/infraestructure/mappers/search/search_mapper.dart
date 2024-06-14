/*import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';
import 'package:alpha_gymnastic_center/domain/entities/search.dart';

class SearchMapper {
  static Search fromJson(Map<String, dynamic> json) {
    return Search(
      courses: (json['courses'] as List)
          .map((courseJson) => CourseMapper.fromJson(courseJson))
          .toList(),
    );
  }

  static Map<String, dynamic> toJson(Search search) {
    return {
      'courses':
          search.courses.map((course) => CourseMapper.toJson(course)).toList(),
    };
  }
}*/

import 'package:alpha_gymnastic_center/domain/entities/searchResult.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/blog/blog_mapper.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/course/course_mapper.dart';

class SearchMapper {
  static SearchResult fromJson(Map<String, dynamic> json) {
    return SearchResult(
      courses: (json['courses'] as List)
          .map((courseJson) => CourseMapper.fromJson(courseJson))
          .toList(),
      blogs: (json['blogs'] as List)
          .map((blogJson) => BlogMapper.fromJson(blogJson))
          .toList()
    );
  }

  static Map<String, dynamic> toJson(SearchResult search) {
    return {
      'courses':
          search.courses.map((course) => CourseMapper.toJson(course)).toList(),

      'blogs':
          search.blogs.map((blog) => BlogMapper.toJson(blog)).toList()
    };
  }
}

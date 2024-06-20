import 'package:alpha_gymnastic_center/domain/entities/blog.dart';
import 'package:alpha_gymnastic_center/domain/entities/course.dart';

class SearchResult {
  List<Course> courses;
  List<Blog> blogs;

  SearchResult({
    required this.courses,
    required this.blogs
    });
}

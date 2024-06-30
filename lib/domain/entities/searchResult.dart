import 'package:alpha_gymnastic_center/domain/entities/searchBlog.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchCourse.dart';

class SearchResult {
  List<SearchCourse> courses;
  List<SearchBlog> blogs;

  SearchResult({
    required this.courses,
    required this.blogs
    });
}

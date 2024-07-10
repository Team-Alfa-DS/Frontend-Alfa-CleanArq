import 'package:alpha_gymnastic_center/domain/entities/searchBlog.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchCourse.dart';
import 'package:alpha_gymnastic_center/domain/entities/searchResult.dart';

class SearchMapper {
  static SearchResult fromJson(Map<String, dynamic> json) {
    
    return SearchResult(
      courses: (json['courses'] as List).map((courseData) => mapSearchCourse(courseData)).toList(), 
      blogs: (json['blogs'] as List).map((blogData) => mapSearchBlog(blogData)).toList()
    ); 
  }

  // static Map<String, dynamic> toJson(SearchResult search) {
  //   return {
  //     'courses':
  //         search.courses.map((course) => CourseMapper.toJson(course)).toList(),

  //     'blogs':
  //         search.blogs.map((blog) => BlogMapper.toJson(blog)).toList()
  //   };
  // }

  static SearchCourse mapSearchCourse(Map<String, dynamic> json) {
    return SearchCourse(
      id: json['id'] as String, 
      title: json['title'] as String, 
      image: json['image'] as String, 
      date: DateTime.parse(json['date'] as String), 
      categoryName: json['category'] as String, 
      trainerName: json['trainer'] as String
    );
  }

  static SearchBlog mapSearchBlog(Map<String, dynamic> json) {
    return SearchBlog(
      id: json['id'] as String, 
      title: json['title'] as String, 
      image: json['image'] as String, 
      date: DateTime.parse(json['date'] as String), 
      categoryName: json['category'] as String, 
      trainerName: json['trainer'] as String
    );
  }
}

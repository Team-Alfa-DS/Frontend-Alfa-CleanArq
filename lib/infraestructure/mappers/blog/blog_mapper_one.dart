import '../../../domain/entities/blog.dart';
import '../trainer/trainer_mapper.dart';

class BlogMapperOne {
  static Blog fromJson(Map<String, dynamic> json) {
    try {
      return Blog(
        id: json['Id'] as String? ?? '',
        title: json['Title'] as String? ?? '',
        description: json['Description'] as String? ?? '',
        category: json['Category'] as String? ?? '',
        images: List<String>.from(json['Images'] ?? []),
        trainer: TrainerMapper.fromJson(json['Trainer'] as Map<String, dynamic>),
        tags: List<String>.from(json['Tags'] ?? []),
        date: json['date'] != null ? DateTime.parse(json['Date']) : null,
      );
    }catch(e){
      print('Error in BlogMapper.fromJson: $e');
      throw e;
    }
  }

  static Map<String, dynamic> toJson(Blog blog) {
    return {
      'id': blog.id,
      'title': blog.title,
      'description': blog.description,
      'category': blog.category,
      'images': blog.images,
      'trainer': blog.trainer != null ? TrainerMapper.toJson(blog.trainer!) : null,
      'tags': blog.tags,
      'date': blog.date?.toIso8601String(),
    };
  }
}
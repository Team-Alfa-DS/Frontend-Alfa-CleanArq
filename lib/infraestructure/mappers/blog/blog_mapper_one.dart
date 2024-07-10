import '../../../domain/entities/blog.dart';
import '../trainer/trainer_mapper.dart';

class BlogMapperOne {
  static Blog fromJson(Map<String, dynamic> json) {
    try {
      return Blog(
        id: json['id'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        category: json['category'] as String? ?? '',
        images: List<String>.from(json['images'] ?? []),
        trainer: TrainerMapper.fromJson(json['trainer'] as Map<String, dynamic>),
        tags: List<String>.from(json['tags'] ?? []),
        date: json['date'] != null ? DateTime.parse(json['date']) : null,
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
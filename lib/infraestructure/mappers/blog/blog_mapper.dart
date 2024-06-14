import '../../../domain/entities/blog.dart';
import '../../../domain/entities/trainer.dart';
import '../trainer/trainer_mapper.dart';

class BlogMapper {
  static Blog fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      images: List<String>.from(json['images'] ?? []),
      trainer: json['trainer'] != null ? TrainerMapper.fromJson(json['trainer']) : null,
      tags: List<String>.from(json['tags'] ?? []),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
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
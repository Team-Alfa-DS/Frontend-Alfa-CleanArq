import '../../../domain/entities/blog.dart';
import '../../../domain/entities/trainer.dart';
import '../trainer/trainer_mapper.dart';

class BlogMapperMany {
  static Blog fromJson(Map<String, dynamic> json) {
    try {
      return Blog(
        id: json['id'] as String? ?? '',
        title: json['name'] as String? ?? '',
        category: json['category'] as String? ?? '',
        image: json['image'] as String? ?? '',
        trainerName: json['trainer'] as String? ?? '',
        date: json['date'] != null ? DateTime.parse(json['date']) : null,
      );
    }catch(e){
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
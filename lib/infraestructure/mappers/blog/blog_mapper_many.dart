import '../../../domain/entities/blog.dart';
import '../../../domain/entities/trainer.dart';
import '../trainer/trainer_mapper.dart';

class BlogMapperMany {
  static Blog fromJson(Map<String, dynamic> json) {
    try {
      return Blog(
        id: json['Id'] as String? ?? '',
        title: json['Name'] as String? ?? '',
        category: json['Category'] as String? ?? '',
        image: json['Image'] as String? ?? '',
        trainerName: json['Trainer'] as String? ?? '',
        date: json['Date'] != null ? DateTime.parse(json['Date']) : null,
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
import '../../../domain/entities/blog.dart';
import '../../../domain/entities/trainer.dart';
import '../trainer/trainer_mapper.dart';

class BlogMapper {
  //! Los cambios hechos a este mapper son por problemas de compatibilidad con el endpoint de search, por favor no hacer merge
  static Blog fromJson(Map<String, dynamic> json) {
    // print(json);
    return Blog(
      id: json['id'],
      title: json['title'],
      description: json['content'],
      category: json['category'],
      images: [''],//List<String>.from(json['images']),
      trainer:  new Trainer(id: json['trainer'], name: 'Not Provided'),//json['trainer'] != null ? TrainerMapper.fromJson(json['trainer']) : null,
      tags: [''],  //List<String>.from(json['tags'] ?? []),
      date: json['publication_date'] != null ? DateTime.parse(json['publication_date']) : null,
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
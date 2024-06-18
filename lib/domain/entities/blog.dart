
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
enum FilterQueryEnum { popular, recent }
class Blog {

  String id;
  String title;
  String? description;
  String category;
  String? image;
  List<String>? images;
  Trainer? trainer;
  String? trainerName;
  List<String>? tags;
  DateTime? date;

  Blog({
     required this.id,
     required this.title,
    this.description,
     required this.category,
      this.image,
      this.images,
      this.trainer,
      this.date,
      this.tags,
      this.trainerName,
  });
}
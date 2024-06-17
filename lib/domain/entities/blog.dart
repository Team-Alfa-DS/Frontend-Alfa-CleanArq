
import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';
enum FilterQueryEnum { popular, recent }
class Blog {

  String id;
  String title;
  String description;
  String category;
  List<String>? images;
  Trainer trainer;
  List<String>? tags;
  DateTime? date;

  Blog({
     required this.id,
     required this.title,
     required this.description,
     required this.category,
      this.images,
     required this.trainer,
      this.date,
      this.tags
  });
}

enum FilterQueryEnum { popular, recent }

class BlogTrainer {
    String id;
    String name;
    BlogTrainer({
       required this.id,
       required this.name
    });
}
//Creo que tengo que importar el Trainer que puso Victor

class Blog {

  String token;
  String title;
  String description;
  String category;
  List<String> images;
  BlogTrainer trainer;
  List<String> tags;
  DateTime date;

  Blog({
     required this.token,
     required this.title,
     required this.description,
     required this.category,
     required this.images,
     required this.trainer,
     required this.date,
     required this.tags
  });
}
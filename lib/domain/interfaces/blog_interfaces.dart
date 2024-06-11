import '../entities/blog.dart';

class ManyBlogsrequest {

    FilterQueryEnum filter;
    int number;
    int perpage;
    BlogTrainer trainer;
    String category;

    ManyBlogsrequest({
      this.filter = FilterQueryEnum.popular,
      required this.number,
      required this.perpage,
      required this.trainer,
      required this.category
    });

}



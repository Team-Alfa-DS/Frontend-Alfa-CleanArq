import '../entities/blog.dart';
import '../entities/trainer.dart';

class ManyBlogsrequest {

    FilterQueryEnum filter;
    int number;
    Trainer trainer;
    String category;

    ManyBlogsrequest({
      this.filter = FilterQueryEnum.popular,
      required this.number,
      required this.trainer,
      required this.category
    });

}



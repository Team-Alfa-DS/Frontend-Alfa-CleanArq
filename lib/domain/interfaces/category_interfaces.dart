import 'package:image_picker/image_picker.dart';

class GetCategoriesRequest {
  final int page;
  final int perPage;

  GetCategoriesRequest({
    required this.page,
    required this.perPage,
  });
}

class CreateCategoryRequest {
  final String name;
  final XFile icon;

  CreateCategoryRequest({
    required this.name,
    required this.icon,
  });
}

class CreateCategoryResponse {
  final String id;

  CreateCategoryResponse({
    required this.id,
  });
}

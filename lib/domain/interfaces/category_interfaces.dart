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
  final String icon;

  CreateCategoryRequest({
    required this.name,
    required this.icon,
  });
}

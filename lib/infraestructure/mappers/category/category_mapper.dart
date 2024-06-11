import 'package:alpha_gymnastic_center/domain/entities/category.dart';

class CategoryMapper {
  static Category fromJson(Map<String, dynamic> json) {
    return Category(
      icon: json['icon'],
      id: json['id'],
      name: json['name'],
    );
  }

  static Map<String, dynamic> toJson(Category category) {
    return {
      'icon': category.icon,
      'id': category.id,
      'name': category.name,
    };
  }
}

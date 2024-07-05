import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      token: json['token'],
      type: json['type'] == 'admin' ? UserRoles.admin : UserRoles.client,
    );
  }
  static User fromJson2(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      token: json['token'],
      type: json['type'] == 'admin' ? UserRoles.admin : UserRoles.client,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'codigo_usuario': user.id,
      'nombre': user.name,
      'correo': user.email,
      'telefono': user.phone,
      'type': user.type,
    };
  }
}

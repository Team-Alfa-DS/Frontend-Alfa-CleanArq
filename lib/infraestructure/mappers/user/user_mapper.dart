import 'package:alpha_gymnastic_center/domain/entities/user.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      token: json['token'],
      role: json['role'] == 'admin' ? UserRoles.admin : UserRoles.regular,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'codigo_usuario': user.id,
      'nombre': user.name,
      'correo': user.email,
      'telefono': user.phone,
      'rol': user.role,
    };
  }
}

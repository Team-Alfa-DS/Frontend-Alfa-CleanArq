// ignore_for_file: prefer_final_fields

enum UserRoles { regular, admin }

class User {
  String id;
  String? name;
  String? email;
  String? phone;
  UserRoles? role;
  String? token;
  String? imagenPerfil;

  User({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.role = UserRoles.regular,
    this.token,
    this.imagenPerfil,
  });
}

// ignore_for_file: prefer_final_fields

enum UserRoles { client, admin }

class User {
  String id;
  String? name;
  String? email;
  String? phone;
  UserRoles? type;
  String? token;
  String? imagenPerfil;

  User({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.type = UserRoles.client,
    this.token,
    this.imagenPerfil,
  });
}

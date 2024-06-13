class Trainer {
  String? id;
  String name;
  int? followers;
  bool? userFollow;
  String? location;

  Trainer({
    this.id,
    required this.name,
    this.followers,
    this.userFollow,
    this.location,
  });
}

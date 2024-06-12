class CreateTrainerRequest {
  final String name;
  final int followers;
  final bool userFollow;
  final String location;

  CreateTrainerRequest({
    required this.name,
    required this.followers,
    required this.userFollow,
    required this.location,
  });
}

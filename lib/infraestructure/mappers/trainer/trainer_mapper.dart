import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';

class TrainerMapper {
  static Trainer fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      name: json['name'],
      followers: json['followers'],
      userFollow: json['userFollow'],
      location: json['location'],
    );
  }

  static Map<String, dynamic> toJson(Trainer trainer) {
    return {
      'id': trainer.id,
      'name': trainer.name,
      'followers': trainer.followers,
      'userFollow': trainer.userFollow,
      'location': trainer.location,
    };
  }
}

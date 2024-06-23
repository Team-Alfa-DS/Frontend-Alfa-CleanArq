import 'package:alpha_gymnastic_center/domain/entities/trainer.dart';

class TrainerMapper {
  static Trainer fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'] as String,
      name: json['name'],
      followers: json['followers'] as int? ?? 0,
      userFollow: json['userFollow'] as bool? ?? false,
      location: json['location'] as String? ?? 'N/A',
    );
  }

  static Map<String, dynamic> toJson(Trainer trainer) {
    final Map<String, dynamic> json = {
      'id': trainer.id,
      'userFollow': trainer.userFollow,
    };

    // Add optional parameters only if they are not null
    json['name'] = trainer.name;
    if (trainer.followers != null) {
      json['followers'] = trainer.followers;
    }
    if (trainer.location != null) {
      json['location'] = trainer.location;
    }

    return json;
  }
}

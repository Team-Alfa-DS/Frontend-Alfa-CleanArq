import 'package:alpha_gymnastic_center/domain/repositories/trainer_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/trainer/trainer_mapper.dart';
import '../../../aplication/localStorage/local_storage.dart';
import '../../../common/result.dart';
import '../../../domain/entities/trainer.dart';

class TrainerRepositoryImpl extends TrainerRepository {
  final IApiRequestManager _apiRequestManager;
  final LocalStorage _localStorage;

  TrainerRepositoryImpl(
      {required IApiRequestManager apiRequestManager,
      required LocalStorage localStorage})
      : _apiRequestManager = apiRequestManager,
        _localStorage = localStorage;

  Future<void> _addAuthorizationHeader() async {
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
  }

  @override
  Future<Result<Trainer>> getOneTrainer(String id) async {
    _addAuthorizationHeader();
    final response = await _apiRequestManager.request<Trainer>(
      '/trainer/one',
      'GET',
      (data) {
        return TrainerMapper.fromJson(data);
      },
      body: {"id": id},
    );
    return response;
  }

  @override
  Future<Result<String>> followTrainer(String trainerId) async {
    _addAuthorizationHeader();
    final response = await _apiRequestManager.request<String>(
      '/trainer/toggle/follow',
      'POST',
      (data) {
        return data;
      },
      body: {"id": trainerId},
    );
    return response;
  }

  @override
  Future<Result<List<Trainer>>> getManyTrainers(
      {required int page, required int perPage, bool? userFollow}) async {
    await _addAuthorizationHeader();
    final token = await _localStorage.getAuthorizationToken();
    _apiRequestManager.setHeaders('Authorization', 'Bearer $token');
    try {
      final response = await _apiRequestManager.request(
        '/trainer/many',
        'GET',
        (data) {
          List<Trainer> trainers = (data['trainers'] as List)
              .map((trainerData) => TrainerMapper.fromJson(trainerData))
              .toList();
          //for (var trainer in trainers) {}
          return trainers;
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Result<int>> trainerUserFollow() async {
    _addAuthorizationHeader();
    final response =
        await _apiRequestManager.request<int>('/auth/login', 'POST', (data) {
      return data;
    });
    return response;
  }
}

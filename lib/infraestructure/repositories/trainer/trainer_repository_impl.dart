import 'dart:ffi';

import 'package:alpha_gymnastic_center/domain/interfaces/trainer_interfaces.dart';
import 'package:alpha_gymnastic_center/domain/repositories/trainer_repository.dart';
import 'package:alpha_gymnastic_center/infraestructure/datasources/api/api_request.dart';
import 'package:alpha_gymnastic_center/infraestructure/mappers/trainer/trainer_mapper.dart';
import 'package:http/http.dart';
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

  @override
  Future<Result<void>> createTrainer(
      CrearTrainerRequest crearTrainerRequest) async {
    print(crearTrainerRequest.name);
    final token = await _localStorage.getAuthorizationToken();
    final response = await _apiRequestManager.request<Trainer>(
      '/trainer/create',
      'POST',
      (data) {
        return TrainerMapper.fromJson(data);
      },
      body: {
        'name': crearTrainerRequest.name,
        'location': crearTrainerRequest.location,
      },
    );

    if (response.statusCode == 201) {
      print('TrainerCreated');
    } else {
      print('failed in to create Trainer: ${response.statusCode}');
    }
    print('REPOSITORY TRAINER');
    print(response);
    print(response.statusCode);
    return Result<void>(
        value: null, failure: null, statusCode: response.statusCode.toString());
  }
}

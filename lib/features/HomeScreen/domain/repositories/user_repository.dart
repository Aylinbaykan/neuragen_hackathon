// domain/repositories/user_repository.dart

import 'package:neuragen_hackathon/features/HomeScreen/data/models/user_model.dart';

import '../../data/models/test_model.dart';

abstract class UserRepository {
  Future<UserModel> getUserInfo();
  Future<List<TestModel>> getTestHistory();
}

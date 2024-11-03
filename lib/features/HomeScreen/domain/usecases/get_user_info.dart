// domain/usecases/get_user_info.dart

import 'package:neuragen_hackathon/features/HomeScreen/data/models/user_model.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/repositories/user_repository.dart';

class GetUserInfo {
  final UserRepository repository;

  GetUserInfo(this.repository);

  Future<UserModel> call() {
    return repository.getUserInfo();
  }
}

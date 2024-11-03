/* import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository_impl.dart';

class LoginUseCase {
  final LoginAuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel> execute(String email, String password) async {
    return await repository.login(email, password);
  }
}
 */
// lib/features/login/domain/usecases/login_use_case.dart

import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserModel> execute(String email, String password) async {
    return await repository.login(email, password);
  }
}

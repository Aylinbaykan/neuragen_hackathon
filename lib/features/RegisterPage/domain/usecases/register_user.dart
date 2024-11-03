// lib/features/register/domain/usecases/register_user.dart

import '../repositories/registration_repository.dart';
import '../../data/models/user_registration_model.dart';

class RegisterUser {
  final RegistrationRepository repository;

  RegisterUser(this.repository);

  Future<void> execute(UserRegistrationModel user) async {
    return await repository.registerUser(user);
  }
}

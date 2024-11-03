// lib/features/register/domain/repositories/registration_repository.dart

import 'package:neuragen_hackathon/features/RegisterPage/data/models/user_registration_model.dart';

abstract class RegistrationRepository {
  Future<void> registerUser(UserRegistrationModel user);
}

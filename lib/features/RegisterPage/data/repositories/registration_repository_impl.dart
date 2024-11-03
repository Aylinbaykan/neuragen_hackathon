// lib/features/register/data/repositories/registration_repository_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/repositories/registration_repository.dart';
import '../../data/models/user_registration_model.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final String apiUrl = 'https://example.com/api/register';

  @override
  Future<void> registerUser(UserRegistrationModel user) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(user.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register user');
    }
  }
}

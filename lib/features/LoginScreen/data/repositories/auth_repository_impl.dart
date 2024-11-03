/* import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

abstract class LoginAuthRepository {
  Future<UserModel> login(String email, String password);
}

class LoginAuthRepositoryImpl implements LoginAuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  LoginAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }
}
 */

// lib/features/login/data/repositories/auth_repository_impl.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String apiUrl = 'https://example.com/api/login';

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to log in');
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    // Giriş yapılıp yapılmadığını kontrol etmek için örnek olarak `false` döndürülüyor.
    await Future.delayed(Duration(seconds: 1)); // Simülasyon için gecikme
    return false; // Oturum geçerli değil
  }
}

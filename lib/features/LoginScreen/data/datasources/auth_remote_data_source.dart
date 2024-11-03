import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Örnek API çağrısı
    var response; //=// await // API çağrısı yapın

    if (response.statusCode == 200) {
      final userData = UserModel.fromJson(response.data);
      return userData;
    } else {
      throw Exception('Login failed');
    }
  }
}

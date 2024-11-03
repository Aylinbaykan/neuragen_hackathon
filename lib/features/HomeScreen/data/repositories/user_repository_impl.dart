// data/repositories/user_repository_impl.dart

import 'package:neuragen_hackathon/features/HomeScreen/data/models/user_model.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/repositories/user_repository.dart';

import '../models/test_model.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel> getUserInfo() async {
    // Mock veri. Gerçek bir API çağrısı ile değiştirilebilir.
    return UserModel(
        name: "Ahmet",
        surname: "Yılmaz",
        email: "ahmet@example.com",
        birthYear: '2017',
        schoolGrade: 'IlkOkulu');
  }

  @override
  Future<List<TestModel>> getTestHistory() async {
    // Mock veri. Gerçek bir API çağrısı ile değiştirilebilir.
    return [
      TestModel(date: "2023-10-01", score: 85),
      TestModel(date: "2023-10-15", score: 90),
    ];
  }
}

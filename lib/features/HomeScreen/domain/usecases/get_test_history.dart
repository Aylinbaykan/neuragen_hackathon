// domain/usecases/get_test_history.dart

import 'package:neuragen_hackathon/features/HomeScreen/data/models/test_model.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/repositories/user_repository.dart';

class GetTestHistory {
  final UserRepository repository;

  GetTestHistory(this.repository);

  Future<List<TestModel>> call() {
    return repository.getTestHistory();
  }
}

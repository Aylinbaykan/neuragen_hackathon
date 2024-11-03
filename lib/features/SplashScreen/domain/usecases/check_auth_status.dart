// domain/usecases/check_auth_status.dart

import '../repositories/auth_repository.dart';

/* lass CheckAuthStatus {
  // Bu, oturum kontrolü yapacak olan bir usecase.
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  Future<bool> call() async {
    return true; //await repository.isLoggedIn();
  }
}
 */

class CheckAuthStatus {
  final AuthStatusRepository repository;

  CheckAuthStatus(this.repository);

  Future<bool> call() async {
    return await repository.isAuthenticated();
  }
}

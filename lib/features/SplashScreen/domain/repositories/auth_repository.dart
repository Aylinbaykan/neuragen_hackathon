// // domain/repositories/auth_repository.dart

// abstract class AuthRepository {
//   Future<bool> isLoggedIn(); // Oturum durumunu kontrol eden bir metot
// }

abstract class AuthStatusRepository {
  Future<bool> isAuthenticated();
}

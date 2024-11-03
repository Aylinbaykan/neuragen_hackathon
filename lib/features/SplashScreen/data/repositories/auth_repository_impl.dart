/* // data/repositories/auth_repository_impl.dart

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> isLoggedIn() async {
    // Burada oturum durumunu kontrol etmek için gerekli işlemler yapılır.
    // Örneğin, SharedPreferences veya herhangi bir veri kaynağından veriyi kontrol edebiliriz.
    return Future.delayed(
        Duration(seconds: 2), () => false); // Oturum yoksa false döndür
  }
}
 */

// lib/features/splash/data/repositories/auth_status_repository_impl.dart

import '../../domain/repositories/auth_repository.dart';

class AuthStatusRepositoryImpl implements AuthStatusRepository {
  @override
  Future<bool> isAuthenticated() async {
    // Burada oturum durumunu kontrol edin, örneğin SharedPreferences veya bir API çağrısı ile
    // Örnek olarak false döndürüyoruz.
    await Future.delayed(Duration(seconds: 1)); // Simülasyon için gecikme
    return false; // Örneğin, oturum geçerli değil
  }
}

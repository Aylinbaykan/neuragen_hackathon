/* // presentation/cubit/splash_cubit.dart

import 'package:bloc/bloc.dart';
import '../../domain/usecases/check_auth_status.dart';

class SplashCubit extends Cubit<bool> {
  final CheckAuthStatus checkAuthStatus;

  SplashCubit(this.checkAuthStatus) : super(false);

  void checkAuthentication() async {
    final isLoggedIn = await checkAuthStatus();
    emit(isLoggedIn); // Oturum durumuna göre ekran yönlendirmesi yapılacak
  }
}
 */

// lib/features/splash/presentation/cubit/splash_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_auth_status.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashAuthenticated extends SplashState {}

class SplashUnauthenticated extends SplashState {}

class SplashCubit extends Cubit<SplashState> {
  final CheckAuthStatus checkAuthStatus;

  SplashCubit(this.checkAuthStatus) : super(SplashInitial());

  Future<void> checkAuthentication() async {
    emit(SplashLoading());
    final isAuthenticated = await checkAuthStatus();
    if (isAuthenticated) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }
}

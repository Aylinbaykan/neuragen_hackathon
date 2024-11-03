/* import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      final user = await loginUseCase.execute(email, password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
 */

// lib/features/login/presentation/bloc/login_cubit.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_use_case.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;
  bool isPasswordVisible = false;
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterPasswordVisibility(
      isPasswordVisible: isPasswordVisible,
    ));
  }

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    if (emailController.text != '' && passwordController.text != '') {
      try {
        final user = await loginUseCase.execute(email, password);
        emit(LoginSuccess(user));
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    } else {
      emit(LoginFailure('E-posta ve şifre alanlarını boş bırakmamalısınız.'));
    }
  }
}

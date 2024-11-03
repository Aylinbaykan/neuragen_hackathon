import '../../data/models/user_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess(this.user);
}

class RegisterPasswordVisibility extends LoginState {
  final bool isPasswordVisible;

  RegisterPasswordVisibility({
    required this.isPasswordVisible,
  });
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

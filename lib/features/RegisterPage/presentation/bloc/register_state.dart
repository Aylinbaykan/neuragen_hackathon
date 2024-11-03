// lib/features/register/presentation/bloc/register_state.dart

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterPasswordVisibility extends RegisterState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  RegisterPasswordVisibility({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });
}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}

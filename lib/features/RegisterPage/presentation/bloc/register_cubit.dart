// lib/features/register/presentation/bloc/register_cubit.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_user.dart';
import '../../data/models/user_registration_model.dart';
import 'register_state.dart';

enum PasswordField { password, confirmPassword }

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUser registerUser;

  RegisterCubit(this.registerUser) : super(RegisterInitial());

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthYearController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void toggleVisibility(PasswordField field) {
    if (field == PasswordField.password) {
      isPasswordVisible = !isPasswordVisible;
    } else if (field == PasswordField.confirmPassword) {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    }

    emit(RegisterPasswordVisibility(
      isPasswordVisible: isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible,
    ));
  }

  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String birthYear,
    String schoolName,
    String password,
    String confirmPassword,
  ) async {
    emit(RegisterLoading());
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        email.isNotEmpty &&
        birthYear.isNotEmpty &&
        schoolName.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password != confirmPassword) {
        emit(RegisterFailure('Şifreler uyuşmuyor'));
      } else {
        try {
          await registerUser.execute(
            UserRegistrationModel(
              firstName: firstName,
              lastName: lastName,
              email: email,
              birthYear: birthYear,
              schoolName: schoolName,
              password: password,
            ),
          );

          emit(RegisterSuccess());
        } catch (e) {
          emit(RegisterFailure(e.toString()));
        }
      }
    } else {
      emit(RegisterFailure('Alanlari boş bırakmamalısın.'));
    }
  }
}

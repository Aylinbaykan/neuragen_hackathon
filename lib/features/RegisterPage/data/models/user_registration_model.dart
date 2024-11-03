// lib/features/register/data/models/user_registration_model.dart

class UserRegistrationModel {
  final String firstName;
  final String lastName;
  final String email;
  final String birthYear;
  final String schoolName;
  final String password;

  UserRegistrationModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthYear,
    required this.schoolName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'birth_year': birthYear,
      'school_name': schoolName,
      'password': password,
    };
  }
}

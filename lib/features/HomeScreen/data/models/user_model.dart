/* // data/models/home_user_registration_model.dart

class HomeUserRegistrationModel {
  final String name;
  final String surname;
  final String birthYear;
  final String schoolGrade;
  final String email;
  final String password;
  final String confirmPassword;

  HomeUserRegistrationModel({
    required this.name,
    required this.surname,
    required this.birthYear,
    required this.schoolGrade,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'birthYear': birthYear,
      'schoolGrade': schoolGrade,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
 */

// data/models/user_model.dart

class UserModel {
  final String name;
  final String surname;
  final String email;
  final String birthYear;
  final String schoolGrade;
  UserModel(
      {required this.name,
      required this.surname,
      required this.email,
      required this.birthYear,
      required this.schoolGrade});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        schoolGrade: json['school_grade'],
        birthYear: json['birth_year']);
  }
}

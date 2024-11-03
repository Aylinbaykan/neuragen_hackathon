// data/models/home_user_registration_response.dart

class HomeUserRegistrationResponse {
  final int id;
  final String name;
  final String surname;
  final String email;
  final String birthYear;
  final String schoolGrade;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final String message;
  final String httpResponse;
  final int statusCode;
  final bool success;

  HomeUserRegistrationResponse({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.birthYear,
    required this.schoolGrade,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.message,
    required this.httpResponse,
    required this.statusCode,
    required this.success,
  });

  factory HomeUserRegistrationResponse.fromJson(Map<String, dynamic> json) {
    return HomeUserRegistrationResponse(
      id: json['data']['id'],
      name: json['data']['name'],
      surname: json['data']['surname'],
      email: json['data']['email'],
      birthYear: json['data']['birth_year'].toString(),
      schoolGrade: json['data']['school_grade'],
      isActive: json['data']['is_active'],
      createdAt: json['data']['created_at'],
      updatedAt: json['data']['updated_at'],
      message: json['message'],
      httpResponse: json['http_response'],
      statusCode: json['statusCode'],
      success: json['success'],
    );
  }
}

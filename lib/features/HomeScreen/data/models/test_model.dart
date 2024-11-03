// data/models/test_model.dart

class TestModel {
  final String date;
  final int score;

  TestModel({required this.date, required this.score});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      date: json['date'],
      score: json['score'],
    );
  }
}

// model/audio_file_model.dart
import '../../domain/entities/audio_file.dart';

class AudioFileModel extends AudioFile {
  AudioFileModel({
    required String audioBase64,
    required String category,
    required int difficultyLevel,
    required int id,
    required String imageBase64,
  }) : super(
          audioBase64: audioBase64,
          category: category,
          difficultyLevel: difficultyLevel,
          id: id,
          imageBase64: imageBase64,
        );

  // Factory constructor to create an instance from JSON
  factory AudioFileModel.fromJson(Map<String, dynamic> json) {
    return AudioFileModel(
      audioBase64: json['audio_base64'],
      category: json['category'],
      difficultyLevel: json['difficulty_level'],
      id: json['id'],
      imageBase64: json['image_base64'],
    );
  }

  // Method to convert an instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'audio_base64': audioBase64,
      'category': category,
      'difficulty_level': difficultyLevel,
      'id': id,
      'image_base64': imageBase64,
    };
  }
}

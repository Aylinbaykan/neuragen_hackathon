// domain/entities/audio_file.dart
// entities/audio_file.dart
class AudioFile {
  final String audioBase64;
  final String category;
  final int difficultyLevel;
  final int id;
  final String imageBase64;

  AudioFile({
    required this.audioBase64,
    required this.category,
    required this.difficultyLevel,
    required this.id,
    required this.imageBase64,
  });
}

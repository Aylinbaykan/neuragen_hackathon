// domain/repositories/audio_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/audio_file.dart';
import '../../../../core/error/failures.dart';

abstract class AudioRepository {
  Future<List<AudioFile>> getAudioFiles();
}

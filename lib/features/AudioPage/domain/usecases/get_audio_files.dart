// domain/usecases/get_audio_files.dart

import '../repositories/audio_repository.dart';
import '../entities/audio_file.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class GetAudioFiles {
  final AudioRepository repository;

  GetAudioFiles(this.repository);

  Future<List<AudioFile>> call() async {
    return await repository.getAudioFiles();
  }
}

// data/repositories/audio_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:neuragen_hackathon/features/AudioPage/data/datasources/audio_remote_data_source.dart';
import '../../domain/entities/audio_file.dart';
import '../../domain/repositories/audio_repository.dart';
import '../models/audio_file_model.dart';
import '../../../../core/error/failures.dart';

class AudioRepositoryImpl implements AudioRepository {
  final AudioRemoteDataSource remoteDataSource;

  AudioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AudioFile>> getAudioFiles() async {
    try {
      print('Fetching audio files...');
      final remoteAudioFiles = await remoteDataSource.getAudioFiles();
      return remoteAudioFiles.map((model) => model as AudioFile).toList();
    } catch (e) {
      throw ServerFailure('Api error');
    }
  }
}

// presentation/cubit/audio_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/audio_file.dart';
import '../../domain/usecases/get_audio_files.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final GetAudioFiles getAudioFiles;

  AudioCubit(this.getAudioFiles) : super(AudioInitial());

  Future<void> fetchAudioFiles() async {
    emit(AudioLoading());
    try {
      final audioFiles = await getAudioFiles();
      emit(AudioLoaded(audioFiles));
    } catch (e) {
      emit(AudioError("Ses dosyaları yüklenirken hata oluştu"));
    }
  }
}

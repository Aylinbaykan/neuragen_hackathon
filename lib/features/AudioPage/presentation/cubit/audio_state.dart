// presentation/cubit/audio_state.dart

part of 'audio_cubit.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioInitial extends AudioState {}

class AudioLoading extends AudioState {}

class AudioLoaded extends AudioState {
  final List<AudioFile> audioFiles;

  const AudioLoaded(this.audioFiles);

  @override
  List<Object> get props => [audioFiles];
}

class AudioError extends AudioState {
  final String message;

  const AudioError(this.message);

  @override
  List<Object> get props => [message];
}

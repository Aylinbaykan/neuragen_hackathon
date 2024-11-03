// presentation/pages/audio_page.dart

import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../domain/usecases/get_audio_files.dart';
import '../cubit/audio_cubit.dart';
import 'package:path_provider/path_provider.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AudioCubit(context.read<GetAudioFiles>())..fetchAudioFiles(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Eğitim Sesleri',
            style: TextStyle(
              fontFamily: 'ComicSans',
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyanAccent, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: BlocBuilder<AudioCubit, AudioState>(
          builder: (context, state) {
            if (state is AudioLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/lottie/loading_animation.json', // Yükleme animasyonu dosyası
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              );
            } else if (state is AudioLoaded) {
              return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.cyanAccent, Colors.pinkAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: state.audioFiles.length,
                    itemBuilder: (context, index) {
                      final audio = state.audioFiles[index];
                      return Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Colors.orange,
                          /* Colors.primaries[index % Colors.primaries.length]
                            .shade100, */
                          child: ListTile(
                            leading: _buildImageFromBase64(audio.imageBase64),
                            title: const Text(
                              'Harfi',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                            trailing: GestureDetector(
                                onTap: () =>
                                    _playAudioFromBase64(audio.audioBase64),
                                child: Lottie.asset(
                                  'assets/playing.json', // Oynatma animasyonu dosyası
                                  width: 50,
                                  height: 50,
                                )),
                          ));
                    },
                  ));
            } else if (state is AudioError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              );
            }
            return Center(
              child: Text(
                'Ses dosyaları yükleniyor...',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  Future<void> _playAudioFromBase64(String base64String) async {
    try {
      Uint8List audioBytes = base64Decode(base64String);

      // Set source from bytes and play
      await _audioPlayer.setSourceBytes(audioBytes);
      await _audioPlayer.resume(); // Ses oynatılıyor
    } catch (e) {
      print('Ses oynatılırken hata oluştu: $e');
    }
  }

  // Base64 verisini görüntüye dönüştüren widget
  Widget _buildImageFromBase64(String base64String) {
    try {
      Uint8List imageBytes = base64Decode(base64String);
      return Image.memory(
        imageBytes,
        width: MediaQuery.of(context).size.width / 10,
        height: MediaQuery.of(context).size.height / 5,
        fit: BoxFit.cover,
      );
    } catch (e) {
      // Hata durumunda varsayılan bir simge gösterme
      return Icon(
        Icons.broken_image,
        size: 50,
        color: Colors.grey,
      );
    }
  }
}

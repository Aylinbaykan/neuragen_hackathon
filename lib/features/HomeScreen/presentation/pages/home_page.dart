// presentation/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neuragen_hackathon/features/AudioPage/data/datasources/audio_remote_data_source.dart';
import 'package:neuragen_hackathon/features/AudioPage/data/repositories/audio_repository_impl.dart';
import 'package:neuragen_hackathon/features/AudioPage/domain/repositories/audio_repository.dart';
import 'package:neuragen_hackathon/features/AudioPage/domain/usecases/get_audio_files.dart';
import 'package:neuragen_hackathon/features/AudioPage/presentation/cubit/audio_cubit.dart';
import 'package:neuragen_hackathon/features/AudioPage/presentation/pages/audio_page.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/usecases/get_test_history.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/usecases/get_user_info.dart';
import 'package:neuragen_hackathon/features/HomeScreen/presentation/cubit/home_cubit.dart';
import 'package:neuragen_hackathon/features/HomeScreen/presentation/widgets/animated_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) =>
          HomeCubit(context.read<GetUserInfo>(), context.read<GetTestHistory>())
            ..loadHomeData(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Konuşma Asistanı',
              style: TextStyle(fontFamily: 'ComicSans')),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                // Logout işlemi burada yapılabilir
              },
            ),
          ],
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
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text("Hata: ${state.error}"));
            }

            return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.cyanAccent, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: SingleChildScrollView(
                    child: Container(
                        height: screenHeight,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Kullanıcı Bilgisi Bölümü
                              Center(
                                child: Lottie.asset(
                                  'assets/kids_playing.json', // Sevimli bir animasyon dosyası
                                  width: screenWidth / 2,
                                  height: screenHeight / 5,
                                  fit: BoxFit.fill,
                                  repeat:
                                      true, // Animasyonun tekrarlanmasını sağlar
                                  animate:
                                      true, // Animasyonun otomatik başlamasını sağlar
                                ),
                              ),
                              //SizedBox(height: screenHeight / 100),

                              // Çocuğun bilgileri bölümü
                              Container(
                                width: screenWidth,
                                padding: const EdgeInsets.all(16),
                                //margin: const EdgeInsets.symmetric(horizontal: 24),
                                decoration: BoxDecoration(
                                  color: Colors.pink.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.pinkAccent.withOpacity(0.4),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Merhaba, ${state.user?.name ?? ''}!',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                        fontFamily: 'ComicSans',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Sınıf: ${state.user?.schoolGrade ?? ''}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.purple),
                                    ),
                                    Text(
                                      'Doğum Yılı: ${state.user?.birthYear ?? ''}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.purple),
                                    ),
                                    Text(
                                      'E-Posta: ${state.user?.email ?? ''}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.purple),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Eğitim Sesleri Butonu
                              AnimatedButton(
                                text: '🎶 Eğitim Sesleri 🎶',
                                color: Colors.pinkAccent,
                                icon: Icons.music_note,
                                onPressed: () {
                                  // Ana Sayfa veya Yönlendirme Yapan Widget
                                  /* Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiProvider(
                                        providers: [
                                          Provider<AudioRepository>(
                                            create: (_) => AudioRepositoryImpl(
                                              remoteDataSource: context.read<
                                                  AudioRemoteDataSource>(),
                                            ),
                                          ),
                                          Provider<GetAudioFiles>(
                                            create: (context) => GetAudioFiles(
                                                context
                                                    .read<AudioRepository>()),
                                          ),
                                          BlocProvider<AudioCubit>(
                                            create: (context) => AudioCubit(
                                                context.read<GetAudioFiles>()),
                                          ),
                                        ],
                                        builder: (context, child) {
                                          return AudioPage();
                                        },
                                      ),
                                    ),
                                  ); */
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MultiProvider(
                                        providers: [
                                          Provider<AudioRemoteDataSource>(
                                            create: (_) =>
                                                AudioRemoteDataSourceImpl(),
                                          ),
                                          Provider<AudioRepository>(
                                            create: (context) =>
                                                AudioRepositoryImpl(
                                              remoteDataSource: context.read<
                                                  AudioRemoteDataSource>(),
                                            ),
                                          ),
                                          Provider<GetAudioFiles>(
                                            create: (context) => GetAudioFiles(
                                                context
                                                    .read<AudioRepository>()),
                                          ),
                                          BlocProvider<AudioCubit>(
                                            create: (context) => AudioCubit(
                                                context.read<GetAudioFiles>()),
                                          ),
                                        ],
                                        child: AudioPage(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 10),

                              // Eğitim Testi Butonu
                              AnimatedButton(
                                text: '📝 Teste Başla 📝',
                                color: Colors.orangeAccent,
                                icon: Icons.assignment,
                                onPressed: () {
                                  // Eğitim testi sayfasına yönlendirme
                                },
                              ),
                              const SizedBox(height: 20),

                              // Geçmiş Testler Başlığı
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 30),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Geçmiş Testler',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                      fontFamily: 'ComicSans',
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 30),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Geçmiş Test Listesi
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.testHistory?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final test = state.testHistory![index];
                                    return Card(
                                      color: Colors
                                          .primaries[
                                              index % Colors.primaries.length]
                                          .shade100,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 4,
                                      child: ListTile(
                                        leading: const Icon(Icons.favorite,
                                            color: Colors.redAccent),
                                        title: Text(
                                          'Test ${index + 1} - ${test.date}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                        subtitle: Text('Skor: ${test.score}',
                                            style: const TextStyle(
                                                color: Colors.green)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ))));
          },
        ),
      ),
    );
  }
}

// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuragen_hackathon/features/LoginScreen/presentation/pages/login_page.dart';
import 'package:provider/provider.dart';

import 'features/LoginScreen/data/repositories/auth_repository_impl.dart';
import 'features/LoginScreen/domain/usecases/login_use_case.dart';
import 'features/LoginScreen/presentation/bloc/login_cubit.dart';
import 'features/SplashScreen/data/repositories/auth_repository_impl.dart';
import 'features/SplashScreen/domain/usecases/check_auth_status.dart';
import 'features/SplashScreen/presentation/cubit/splash_cubit.dart';
import 'features/SplashScreen/presentation/pages/splash_screen.dart';

// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final authRepository = AuthRepositoryImpl(); // Login işlemleri için
  final authStatusRepository = AuthStatusRepositoryImpl(); // Oturum durumu için
  final checkAuthStatus = CheckAuthStatus(authStatusRepository);
  final loginUseCase = LoginUseCase(authRepository);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => checkAuthStatus),
        Provider(create: (_) => loginUseCase),
        BlocProvider(create: (_) => LoginCubit(loginUseCase)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aina',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => Scaffold(body: Center(child: Text('Home Page'))),
      },
    );
  }
}

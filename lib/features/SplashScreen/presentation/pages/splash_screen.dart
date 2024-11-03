/* // presentation/pages/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/splash_cubit.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, bool>(
      listener: (context, isLoggedIn) {
        if (isLoggedIn) {
          // Eğer oturum açıksa ana sayfaya yönlendir
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Oturum yoksa giriş sayfasına yönlendir
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        body: Container(
          child: Center(
            child: Lottie.asset('assets/splash_screen_animation.json'),
          ),
        ),
      ),
    );
  }
}
 */

// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../cubit/splash_cubit.dart';

/* class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, bool>(
        listener: (context, isAuthenticated) {
          if (isAuthenticated) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: Center(child: Text('Splash Screen')),
      ),
    );
  }
}
 */

// lib/features/splash/presentation/pages/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashCubit(context.read<CheckAuthStatus>())..checkAuthentication(),
      child: Scaffold(
        body: Center(
          child: BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              if (state is SplashAuthenticated) {
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is SplashUnauthenticated) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: BlocBuilder<SplashCubit, SplashState>(
              builder: (context, state) {
                if (state is SplashLoading) {
                  return CircularProgressIndicator();
                }
                return Text(
                  'Welcome to Clean Architecture App',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

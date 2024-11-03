import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuragen_hackathon/features/HomeScreen/data/repositories/user_repository_impl.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/repositories/user_repository.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/usecases/get_test_history.dart';
import 'package:neuragen_hackathon/features/HomeScreen/domain/usecases/get_user_info.dart';
import 'package:neuragen_hackathon/features/RegisterPage/data/repositories/registration_repository_impl.dart';
import 'package:neuragen_hackathon/features/RegisterPage/domain/repositories/registration_repository.dart';
import 'package:neuragen_hackathon/features/RegisterPage/domain/usecases/register_user.dart';
import 'package:neuragen_hackathon/features/RegisterPage/presentation/pages/register_page.dart';
import 'package:provider/provider.dart';
import '../../../../Static/text_form_field.dart';
import '../../../HomeScreen/presentation/pages/home_page.dart';
import '../../../RegisterPage/presentation/bloc/register_cubit.dart';
import '../../domain/usecases/login_use_case.dart';
import '../bloc/login_cubit.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ekran boyutlarını hesapla
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => LoginCubit(context.read<LoginUseCase>()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade100, Colors.blue.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        Provider<UserRepository>(
                          create: (_) => UserRepositoryImpl(),
                        ),
                        Provider<GetUserInfo>(
                          create: (context) =>
                              GetUserInfo(context.read<UserRepository>()),
                        ),
                        Provider<GetTestHistory>(
                          create: (context) =>
                              GetTestHistory(context.read<UserRepository>()),
                        ),
                      ],
                      child: HomePage(),
                    ),
                  ),
                );
              } else if (state is LoginFailure) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultiProvider(
                      providers: [
                        Provider<UserRepository>(
                          create: (_) => UserRepositoryImpl(),
                        ),
                        Provider<GetUserInfo>(
                          create: (context) =>
                              GetUserInfo(context.read<UserRepository>()),
                        ),
                        Provider<GetTestHistory>(
                          create: (context) =>
                              GetTestHistory(context.read<UserRepository>()),
                        ),
                      ],
                      child: HomePage(),
                    ),
                  ),
                );

                /* ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                ); */
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Karakter İkonu
                    Container(
                      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                      child: Image.asset(
                        'assets/children.png',
                        height: screenHeight * 0.17, // Ekrana göre ikon boyutu
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Macera Başlıyor!',
                      style: TextStyle(
                        fontSize:
                            screenHeight * 0.035, // Ekrana göre font boyutu
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      'Hadi, birlikte keşfetmeye başlayalım!',
                      style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        color: Colors.purple.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    // Email TextField
                    Container(
                      child: CustomEntryField(
                        controller: context.read<LoginCubit>().emailController,
                        allowedType: AllowedEntryInputType.email,
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        hint: 'E-Posta',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Şifre TextField
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        bool isPasswordVisible = false;
                        if (state is RegisterPasswordVisibility) {
                          isPasswordVisible = state.isPasswordVisible;
                        }
                        return CustomEntryField(
                          controller:
                              context.read<LoginCubit>().passwordController,
                          hint: 'Şifre',
                          allowedType: AllowedEntryInputType.any,
                          obscure: !isPasswordVisible, // Gizlilik durumu
                          prefixIcon: Icon(Icons.lock, color: Colors.blue),
                          toggleVisibility: () => context
                              .read<LoginCubit>()
                              .togglePasswordVisibility(), // Şifre alanı için toggleVisibility
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    // Giriş Butonu
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginCubit>().login(
                              context.read<LoginCubit>().emailController.text,
                              context
                                  .read<LoginCubit>()
                                  .passwordController
                                  .text,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.11,
                          vertical: screenHeight * 0.018,
                        ),
                        shadowColor: Colors.orangeAccent,
                        elevation: 8,
                      ),
                      child: Text(
                        'Giriş Yap',
                        style: TextStyle(
                          fontSize: screenHeight * 0.028,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    // Kayıt ol butonu
                    TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Kayıt ekranına geçiş
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MultiProvider(
                                providers: [
                                  Provider<RegistrationRepository>(
                                    create: (_) => RegistrationRepositoryImpl(),
                                  ),
                                  Provider<RegisterUser>(
                                    create: (context) => RegisterUser(
                                        context.read<RegistrationRepository>()),
                                  ),
                                  BlocProvider<RegisterCubit>(
                                    create: (context) => RegisterCubit(
                                        context.read<RegisterUser>()),
                                  ),
                                ],
                                child: RegisterPage(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Henüz hesabın yok mu?\nKayıt Ol',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: screenHeight * 0.021,
                            decoration: TextDecoration.underline,
                          ),
                        )),
                    SizedBox(height: screenHeight * 0.02),
                    // Alt Kısımda Yıldızlar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.pink.shade300,
                          size: screenHeight * 0.04,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Icon(
                          Icons.star,
                          color: Colors.orange.shade300,
                          size: screenHeight * 0.05,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Icon(
                          Icons.star,
                          color: Colors.blue.shade300,
                          size: screenHeight * 0.04,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

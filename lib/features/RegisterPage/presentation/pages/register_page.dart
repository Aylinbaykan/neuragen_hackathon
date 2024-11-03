/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Static/text_form_field.dart';
import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';
import '../../domain/usecases/register_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _stateExampleState();
}

class _stateExampleState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => RegisterCubit(context.read<RegisterUser>()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        // AppBar ile geri butonu ekledik
        appBar: AppBar(
          title: Text(
            'Kayıt Ol!',
            style: TextStyle(
              fontSize: screenHeight * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          backgroundColor: Colors.pink.shade100,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade100, Colors.blue.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenWidth * 0.02,
                  ),
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
                      fontSize: screenHeight * 0.035, // Ekrana göre font boyutu
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

                  SizedBox(height: screenHeight * 0.02),
                  // E-posta giriş alanı
                  Container(
                    child: CustomEntryField(
                      controller: emailController,
                      allowedType: AllowedEntryInputType.email,
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                      hint: 'E-Posta',
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      bool isPasswordVisible = false;
                      bool isConfirmPasswordVisible = false;

                      if (state is RegisterPasswordVisibility) {
                        isPasswordVisible = state.isPasswordVisible;
                        isConfirmPasswordVisible =
                            state.isConfirmPasswordVisible;
                      }

                      return Column(
                        children: [
                          CustomEntryField(
                            controller: passwordController,
                            hint: 'Şifre',
                            allowedType: AllowedEntryInputType.any,
                            obscure: !isPasswordVisible, // Gizlilik durumu
                            prefixIcon: Icon(Icons.lock, color: Colors.blue),
                            toggleVisibility: () => context
                                .read<RegisterCubit>()
                                .toggleVisibility(PasswordField
                                    .password), // Şifre alanı için toggleVisibility
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          CustomEntryField(
                            controller: confirmPasswordController,
                            hint: 'Tekrar Şifre',
                            prefixIcon: Icon(Icons.lock, color: Colors.blue),
                            allowedType: AllowedEntryInputType.any,
                            obscure:
                                !isConfirmPasswordVisible, // Gizlilik durumu
                            toggleVisibility: () => context
                                .read<RegisterCubit>()
                                .toggleVisibility(PasswordField
                                    .confirmPassword), // Onay alanı için toggleVisibility
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  ElevatedButton(
                    onPressed: () {
                      context.read<RegisterCubit>().register(
                            confirmPasswordController.text,
                            emailController.text,
                            passwordController.text,
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
                      'Kayıt Ol',
                      style: TextStyle(
                        fontSize: screenHeight * 0.028,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
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
                  SizedBox(height: screenHeight * 0.02),
                  // Kayıt sonrası uyarı veya başarı mesajı
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Kayıt başarılı!')),
                        );
                        Navigator.pop(
                            context); // Kayıt sonrası giriş ekranına dön
                      } else if (state is RegisterFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Container(); // Başka bir durumda boş bir widget
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Static/text_form_field.dart';
import '../bloc/register_cubit.dart';
import '../bloc/register_state.dart';
import '../../domain/usecases/register_user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _stateExampleState();
}

class _stateExampleState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => RegisterCubit(context.read<RegisterUser>()),
      child: Scaffold(
          backgroundColor: Colors.pink.shade100,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text(
              'Kayıt Ol!',
              style: TextStyle(
                fontSize: screenHeight * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            backgroundColor: Colors.pink.shade100,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              // height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade100, Colors.blue.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.02),
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
                    SizedBox(height: screenHeight * 0.02),
                    CustomEntryField(
                      controller:
                          context.read<RegisterCubit>().firstNameController,
                      hint: 'Ad',
                      allowedType: AllowedEntryInputType.any,
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    CustomEntryField(
                      controller:
                          context.read<RegisterCubit>().lastNameController,
                      hint: 'Soyad',
                      allowedType: AllowedEntryInputType.any,
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    CustomEntryField(
                      controller: context.read<RegisterCubit>().emailController,
                      allowedType: AllowedEntryInputType.email,
                      hint: 'E-Posta',
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    CustomEntryField(
                      controller:
                          context.read<RegisterCubit>().birthYearController,
                      allowedType: AllowedEntryInputType.onlyNumber,
                      hint: 'Doğum Yılı',
                      prefixIcon: Icon(Icons.date_range, color: Colors.blue),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    CustomEntryField(
                      controller:
                          context.read<RegisterCubit>().schoolNameController,
                      hint: 'Okul Adı',
                      allowedType: AllowedEntryInputType.any,
                      prefixIcon: Icon(Icons.school, color: Colors.blue),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        bool isPasswordVisible = false;
                        bool isConfirmPasswordVisible = false;

                        if (state is RegisterPasswordVisibility) {
                          isPasswordVisible = state.isPasswordVisible;
                          isConfirmPasswordVisible =
                              state.isConfirmPasswordVisible;
                        }

                        return Column(
                          children: [
                            CustomEntryField(
                              controller: context
                                  .read<RegisterCubit>()
                                  .passwordController,
                              hint: 'Şifre',
                              allowedType: AllowedEntryInputType.any,
                              obscure: !isPasswordVisible,
                              toggleVisibility: () => context
                                  .read<RegisterCubit>()
                                  .toggleVisibility(PasswordField.password),
                              prefixIcon: Icon(Icons.lock, color: Colors.blue),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            CustomEntryField(
                              controller: context
                                  .read<RegisterCubit>()
                                  .confirmPasswordController,
                              hint: 'Tekrar Şifre',
                              allowedType: AllowedEntryInputType.any,
                              obscure: !isConfirmPasswordVisible,
                              toggleVisibility: () => context
                                  .read<RegisterCubit>()
                                  .toggleVisibility(
                                      PasswordField.confirmPassword),
                              prefixIcon: Icon(Icons.lock, color: Colors.blue),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RegisterCubit>().register(
                              context
                                  .read<RegisterCubit>()
                                  .firstNameController
                                  .text,
                              context
                                  .read<RegisterCubit>()
                                  .lastNameController
                                  .text,
                              context
                                  .read<RegisterCubit>()
                                  .emailController
                                  .text,
                              context
                                  .read<RegisterCubit>()
                                  .birthYearController
                                  .text,
                              context
                                  .read<RegisterCubit>()
                                  .schoolNameController
                                  .text,
                              context
                                  .read<RegisterCubit>()
                                  .passwordController
                                  .text,
                              context
                                  .read<RegisterCubit>()
                                  .confirmPasswordController
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
                        'Kayıt Ol',
                        style: TextStyle(
                          fontSize: screenHeight * 0.028,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
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
                    SizedBox(height: screenHeight * 0.02),
                    // Kayıt sonrası uyarı veya başarı mesajı
                    BlocConsumer<RegisterCubit, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Kayıt başarılı!')),
                          );
                          Navigator.pop(
                              context); // Kayıt sonrası giriş ekranına dön
                        } else if (state is RegisterFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(); // Başka bir durumda boş bir widget
                      },
                    ),
                    SizedBox(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

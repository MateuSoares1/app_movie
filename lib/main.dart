import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/pages/login/login_page.dart';
import 'package:movie_app/pages/main/main_page.dart';
import 'package:movie_app/services/auth_service.dart';
import 'package:movie_app/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCq0AiFC1D-MJs1qZG5T1oXDIUuUpBrqbA",
      appId: "1:994532702725:android:52990be625e58a63083a6c",
      messagingSenderId: "994532702725",
      projectId: "appmovie-2d336",
    ),
  );

  await AuthService().init();

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          surface: AppColors.backgroundColor,
          secondary: AppColors.desertSand,
        ),
      ),
      home: AuthService().user == null ? const LoginPage() : const MainPageView(),
    );
  }
}

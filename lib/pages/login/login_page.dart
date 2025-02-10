import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/pages/main/main_page.dart';
import 'package:movie_app/services/auth_service.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/app_button_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonController = AppButtonController();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(children: [
          const Spacer(
            flex: 30,
          ),
          Image.asset(
            'assets/logo.png',
            width: 180,
          ),
          const Spacer(flex: 30),
          Lottie.asset('assets/login_page_animation.json'),
          const Spacer(flex: 30),
          AppButton(
            controller: buttonController,
            buttonColor: Colors.red[900],
            onPressed: () async {
              buttonController.isLoading.value = true;
              final result = await AuthService().signInWithGoogle();
              buttonController.isLoading.value = false;
              if (result) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPageView(),
                  ),
                );
              }
            },
            icon: FontAwesome.google,
            label: 'Login com Google',
          ),
          const Spacer(flex: 10),
        ]),
      ),
    );
  }
}

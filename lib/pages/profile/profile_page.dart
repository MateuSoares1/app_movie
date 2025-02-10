// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:movie_app/pages/login/login_page.dart';
import 'package:movie_app/services/auth_service.dart';
import 'package:movie_app/services/global_service.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/app_button_controller.dart';
import 'package:movie_app/widgets/app_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user;
    final buttonController = AppButtonController();

    return AppScaffold(
      body: user == null
          ? const Text(
              'Entre com Goggle para ver seus dados.',
              style: TextStyle(fontSize: 28),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.width * 0.25) * MediaQuery.of(context).devicePixelRatio,
                    width: (MediaQuery.of(context).size.width * 0.25) * MediaQuery.of(context).devicePixelRatio,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                    child: user.photoURL != null
                        ? CachedNetworkImage(
                            imageUrl: user.photoURL!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(FontAwesome.user_circle),
                  ),
                  const SizedBox(height: 20),
                  Text(user.displayName ?? ''),
                  const SizedBox(height: 20),
                  Text(user.email ?? ''),
                  const SizedBox(height: 30),
                  AppButton(
                    controller: buttonController,
                    buttonColor: Colors.red[200],
                    onPressed: () async {
                      buttonController.isLoading.value = true;
                      bool result = await AuthService().signOutFromGoogle();
                      buttonController.isLoading.value = false;

                      if (result) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false,
                        );

                        GlobalService().activePage.value = 0;
                      }
                    },
                    label: 'Logout',
                  ),
                ],
              ),
            ),
    );
  }
}

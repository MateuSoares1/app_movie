import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  const AppScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        top: false,
        child: body,
      ),
    );
  }
}

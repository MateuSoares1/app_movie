import 'package:flutter/material.dart';
import 'package:movie_app/widgets/app_button_controller.dart';

class AppButton extends StatelessWidget {
  final AppButtonController controller;
  final Function() onPressed;
  final String label;
  final IconData? icon;
  final Color? buttonColor;
  final Color iconColor;
  final Color labelColor;

  const AppButton({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.label,
    this.buttonColor,
    this.labelColor = Colors.white,
    this.icon,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (context, isLoading, _) {
          return ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
            ),
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircularProgressIndicator(
                      color: labelColor,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: iconColor,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        label,
                        style: TextStyle(color: labelColor),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
          );
        });
  }
}

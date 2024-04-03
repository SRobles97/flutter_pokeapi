import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;

  const CustomIconButton(
      {super.key, required this.iconPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ImageIcon(AssetImage(iconPath)),
      onPressed: onPressed,
    );
  }
}

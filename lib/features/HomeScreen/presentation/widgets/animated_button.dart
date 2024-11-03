// presentation/widgets/animated_button.dart

import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final IconData icon;

  const AnimatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.6),
              spreadRadius: 2,
              blurRadius: 8,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

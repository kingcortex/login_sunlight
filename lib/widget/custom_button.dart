import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color buttonColor;
  final Color textColor;
  final String text;
  final double width;
  const CustomButton({
    super.key,
    this.onPressed,
    required this.buttonColor,
    required this.textColor,
    required this.text,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          elevation: const MaterialStatePropertyAll<double>(0),
          backgroundColor: MaterialStatePropertyAll<Color>(buttonColor),
          textStyle: MaterialStatePropertyAll<TextStyle>(
            GoogleFonts.anonymousPro(
              fontSize: 12,
              color: textColor,
            ),
          ),
          minimumSize: MaterialStatePropertyAll<Size>(Size(width, 34))),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}

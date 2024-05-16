import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.screenWidth,
      required this.screenHeight,
      required this.text,
      required this.onpressed,
      required this.bColor,
      this.sColor,
      required this.tColor,
      required this.fontSize,
        required this.radius
      });

  final double screenWidth;
  final double screenHeight;
  final String text;
  final Function() onpressed;
  final Color bColor;
  final Color tColor;
  Color? sColor;
  final double fontSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            side: MaterialStatePropertyAll(
                BorderSide(color: sColor ?? Colors.transparent)),
            backgroundColor: MaterialStatePropertyAll(bColor),
            shadowColor: const MaterialStatePropertyAll(Colors.transparent),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)))),
        onPressed: onpressed,
        child: Text(
          text,
          style: GoogleFonts.prompt(color: tColor, fontSize: fontSize,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

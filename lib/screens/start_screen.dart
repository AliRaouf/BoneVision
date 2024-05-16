import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 1.sw,
            height: 0.2.sh,
            decoration: BoxDecoration(
              color: Color(0xff97dfe3),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(65)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("WELCOME!",
                      style: GoogleFonts.prompt(
                          color: Color(0xff232425),
                          fontWeight: FontWeight.bold,
                          fontSize: 32.w)),
                  Text("Get your report immediately",
                      style: GoogleFonts.prompt(
                          color: Color(0xff232425),
                          fontWeight: FontWeight.w500,
                          fontSize: 18.w))
                ],
              ),
            ),
          ),
          Container(
            height: 425.h,
            width: 1.sw,
            child: Column(
              children: [
                Image.asset("assets/images/1.png",),
                Container(height: 235.h,
                    child: Image.asset("assets/images/2.png"))
              ],
            ),
          ),
          CustomButton(radius: 10,
              screenWidth: 0.8.sw,
              screenHeight: 50.h,
              text: "Let's Start",
              onpressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()));
              },
              bColor: Color(0xff97dfe3),
              tColor: Color(0xff232425),
              fontSize: 32.w),
          SizedBox(height: screenHeight * 0.03),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Bone',
                  style: TextStyle(
                      color: Color(0xff97dfe3),
                      fontWeight: FontWeight.w700,
                      fontSize: 35.w),
                ),
                TextSpan(
                  text: 'Vision',
                  style: GoogleFonts.prompt(
                      color: Color(0xffa9a9a9),
                      fontWeight: FontWeight.w700,
                      fontSize: 35.w),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

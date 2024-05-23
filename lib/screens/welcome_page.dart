import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/screens/login_screen.dart';
import 'package:bonevision/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage("assets/images/img.png"), fit: BoxFit.cover)
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have a great experience with",
                style: TextStyle(
                    color: Color(0xffa9a9a9),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.w),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Bone',
                      style: GoogleFonts.prompt(
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
              ),
              Container(
                height: .5.sh,
                width: 1.sw,
                child: Image.asset("assets/images/3.png",fit: BoxFit.contain,),
              ),
              CustomButton(
                  radius: 20,
                  screenWidth: 0.55.sw,
                  screenHeight: 0.075.sh,
                  text: "Create Account",
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  bColor: Color(0xff97dfe3),
                  tColor: Color(0xff232425),
                  fontSize: 16.w),
              SizedBox(
                height: 0.05.sh,
              ),
              CustomButton(
                  radius: 20,
                  screenWidth: 0.55.sw,
                  screenHeight: 0.075.sh,
                  text: "Login",
                  onpressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  bColor: Color(0xff284448),
                  tColor: Color(0xffFAFAFA),
                  fontSize: 18.w),
            ],
          ),
        ),
      ),
    );
  }
}

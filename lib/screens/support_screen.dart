import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/screens/support_chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Bone',
                    style: GoogleFonts.prompt(
                        color: const Color(0xff97dfe3),
                        fontWeight: FontWeight.w700,
                        fontSize: 35.w),
                  ),
                  TextSpan(
                    text: 'Vision',
                    style: GoogleFonts.prompt(
                        color: const Color(0xffa9a9a9),
                        fontWeight: FontWeight.w700,
                        fontSize: 35.w),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
            height: 150.h,
            width: 1.sw,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/img_1.png"),
                    fit: BoxFit.cover))),
        Text(
          "Help Center",
          style: GoogleFonts.prompt(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff21BE44)),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.verified_rounded,
                color: Color(0xff21BE44),
              ),
              Text("Best Experience")
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.verified_rounded,
                color: Color(0xff21BE44),
              ),
              Text("Unlimited Chatting with Professionals")
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50.h),
          child: Center(
            child: CustomButton(
                screenWidth: 280.w,
                screenHeight: 80.h,
                text: "Chat Now",
                onpressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SupportChatScreen()));
                },
                bColor: const Color(0xff21BE44),
                tColor: const Color(0xfffafafa),
                fontSize: 32.sp,
                radius: 20),
          ),
        )
      ]),
    );
  }
}

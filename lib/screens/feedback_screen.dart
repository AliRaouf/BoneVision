import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/component/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../component/gradient_text.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: GradientText("BoneVision",
            style: GoogleFonts.skranji(fontSize: 18.sp),
            gradient:
                LinearGradient(colors: [Color(0xff7bc3cd), Color(0xff3e6267)])),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Contact Us",
                    style: GoogleFonts.prompt(
                        fontSize: 16.sp,
                        color: Color(0xff12696f),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  "We are happy to receive your reviews and suggestions",
                  style: GoogleFonts.prompt(
                      fontSize: 12.sp, color: Color(0xff8a8a8a)),
                ),
              ),
              CustomTextFormField(
                  validate: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return "Name Can't be Empty.";
                    }
                  },
                  readOnly: false,
                  hint: "Full Name",
                  label: "Name",
                  obscureText: false),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: CustomTextFormField(
                    validate: (value) {
                      if (value!.isEmpty || value.trim().isEmpty) {
                        return "E-mail Can't be Empty.";
                      }
                    },
                    readOnly: false,
                    hint: "Email Address",
                    label: "Email",
                    obscureText: false),
              ),
              IntlPhoneField(
                controller: phoneController,
                initialCountryCode: "EG",
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xff232425))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xff232425))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xff232425))),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xff232425)))),
              ),
              SizedBox(height: 10.h,),
              TextFormField(
                controller: commentController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return "Can't be Empty";
                  }
                },
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                    labelText: "Comments",
                    labelStyle: GoogleFonts.prompt(
                        fontSize: 18.sp, color: Color(0xff8a8a8a)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
              SizedBox(height: 30.h,),
              CustomButton(
                  screenWidth: 100.w,
                  screenHeight: 40.h,
                  text: "Send",
                  onpressed: (){},
                  bColor: Color(0xff12696f),
                  tColor: Color(0xfffafafa),
                  fontSize: 14.sp,
                  radius: 7)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/component/custom_form_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    TextEditingController emailController =
        TextEditingController(text: cubit.user?.email ?? "");
    TextEditingController genderController =
        TextEditingController(text: cubit.gender ?? "");
    TextEditingController ageController = TextEditingController(
        text: "${cubit.calculateAge(cubit.timestampToDateTime(cubit.date??Timestamp.fromMicrosecondsSinceEpoch(100000)))} Years");
    return Scaffold(appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 64.w,
                backgroundImage: NetworkImage(cubit.profileImage==""?"https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg":
                    "${cubit.profileImage ?? "https://static.vecteezy.com/system/resources/previews/009/292/244/original/default-avatar-icon-of-social-media-user-vector.jpg"}"),
              ),
              Text(cubit.userName?? cubit.user!.displayName!,
                  style:
                      GoogleFonts.prompt(fontSize: 20.w, color: Color(0xff232425))),
              Container(width: 300.w,
                child: CustomTextFormField(
                  readOnly: true,
                  hint: "Email",
                  label: "Email",
                  obscureText: false,
                  controller: emailController,
                ),
              ),
              Container(width: 300.w,margin: EdgeInsets.symmetric(vertical: 15.h),
                child: CustomTextFormField(
                  readOnly: true,
                  hint: "Gender",
                  label: "Gender",
                  obscureText: false,
                  controller: genderController,
                ),
              ),
              Container(width: 300.w,
                child: CustomTextFormField(
                  readOnly: true,
                  hint: "Age",
                  label: "Age",
                  obscureText: false,
                  controller: ageController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

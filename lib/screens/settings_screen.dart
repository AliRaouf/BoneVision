import 'package:bonevision/screens/change_password_screen.dart';
import 'package:bonevision/screens/edit_profile.dart';
import 'package:bonevision/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/user/user_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: GoogleFonts.prompt(),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        child: Column(
          children: [
            ElevatedButton(
                style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: Color(0xff2a2a2a),
                    ),
                    Text(" View Profile",
                        style: GoogleFonts.prompt(
                            fontSize: 16.sp, color: Color(0xff232425))),
                  ],
                )),
            ElevatedButton(
                style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: Color(0xff2a2a2a),
                    ),
                    Text(" Edit Profile",
                        style: GoogleFonts.prompt(
                            fontSize: 16.sp, color: Color(0xff232425))),
                  ],
                )),
            ElevatedButton(
                style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen(),
                      ));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.password_outlined,
                      color: Color(0xff2a2a2a),
                    ),
                    Text(" Change Password",
                        style: GoogleFonts.prompt(
                            fontSize: 16.sp, color: Color(0xff232425))),
                  ],
                )),
            ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(0)),
                onPressed: () {
                  cubit.userSignOut(context);
                  cubit.userName = null;
                  cubit.userEmail = null;
                  cubit.date = null;
                  cubit.gender = null;
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Color(0xff2a2a2a),
                    ),
                    Text(" Logout",
                        style: GoogleFonts.prompt(
                            fontSize: 16.sp, color: Color(0xff232425))),
                  ],
                )),
          ],
        ),
      )),
    );
  }
}

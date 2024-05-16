  import 'dart:io';
  import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/bloc/xray/xray_cubit.dart';
  import 'package:bonevision/screens/images_screen.dart';
import 'package:bonevision/screens/settings_screen.dart';
  import 'package:bonevision/screens/support_screen.dart';
import 'package:bonevision/screens/upload_test_screen.dart';
  import 'package:convex_bottom_bar/convex_bottom_bar.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:google_fonts/google_fonts.dart';

  class HomeScreen extends StatefulWidget {
    HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    int _activeIndex = 0;

    @override
    Widget build(BuildContext context) {
      var cubit = UserCubit.get(context);
      return Scaffold(
        bottomNavigationBar: ConvexAppBar(activeColor: Color(0xff86E3EF),
          color: Color(0xffFAFAFA),
          backgroundColor: Color(0xff284448),
          style: TabStyle.fixedCircle,
          items: [
            TabItem(icon: Icons.home_outlined, activeIcon: Icon(Icons.home)),
            TabItem(icon: Icons.image_outlined, activeIcon: Icon(Icons.image)),
            TabItem(icon: Icons.add),
            TabItem(
                icon: Icons.support_agent_outlined,
                activeIcon: Icon(Icons.support_agent)),
            TabItem(icon: Icons.settings_outlined, activeIcon: Icon(Icons.settings)),
          ],
          initialActiveIndex: _activeIndex,
          onTap: (int i) async => {
            if (i == 2)
              {await XrayCubit.get(context).chooseUserXray(), setState(() => _activeIndex = i)}
            else
              {setState(() => _activeIndex = i)}
          },
        ),
        body: IndexedStack(
          index: _activeIndex,
          children: [
            Scaffold(appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Hey! Welcome ${cubit.userName??""}",
                  style: GoogleFonts.prompt(
                      fontSize: 20.w, color: Color(0xff232425))),
            ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 1.sw,
                      height: 35.h,
                      color: Color(0xff87e3f2),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0.w),
                            child: Text("Upload Image",
                                style: GoogleFonts.prompt(
                                    fontSize: 20.w, color: Color(0xff232425))),
                          )
                        ],
                      ),
                    ),
                    cubit.file != null
                        ? Container(
                            margin: EdgeInsets.symmetric(vertical: 20.h),
                            width: 320.w,
                            height: 220.h,
                            child: Image.file(
                              File(cubit.file!.path),
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(vertical: 20.h),
                            width: 340.w,
                            height: 220.h,
                            color: Colors.grey[200],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_search_rounded,
                                  color: Colors.grey[400],
                                  size: 150.w,
                                ),
                                Text("UPLOAD IMAGE",
                                    style: TextStyle(
                                        fontSize: 20.w,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                    Container(
                      width: 1.sw,
                      height: 35.h,
                      color: Color(0xff87e3f2),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 12.0.w),
                            child: Text("Last Uploaded",
                                style: GoogleFonts.prompt(
                                    fontSize: 20.w, color: Color(0xff232425))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Content for Image tab (index 1)
            ImagesScreen(),
            // Content for Add tab (index 2)
            UploadTestScreen(),
            // Content for Support tab (index 3)
            SupportScreen(),
            // Content for Profile tab (index 4)
            SettingsScreen(),
          ],
        ),
      );
    }
  }

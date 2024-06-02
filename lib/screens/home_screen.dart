import 'package:bonevision/bloc/doctor/doctor_cubit.dart';
import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/bloc/xray/xray_cubit.dart';
import 'package:bonevision/component/clipcontainer.dart';
import 'package:bonevision/component/gradient_text.dart';
import 'package:bonevision/screens/feedback_screen.dart';
import 'package:bonevision/screens/images_screen.dart';
import 'package:bonevision/screens/settings_screen.dart';
import 'package:bonevision/screens/support_chat_screen.dart';
import 'package:bonevision/screens/support_screen.dart';
import 'package:bonevision/screens/upload_test_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeIndex = 0;
  List tests = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    if (cubit.type == 'doctor') {
      return BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text("Welcome Back Doctor!",
                    style: GoogleFonts.prompt(
                        fontSize: 20.w, color: Color(0xff232425))),
              ),
              body: StreamBuilder(
                  stream: DoctorCubit.get(context).messagesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("error"),
                      );
                    } else if (snapshot.hasData && snapshot.data != null) {
                      QuerySnapshot values = snapshot.data as QuerySnapshot;
                      print(values.docs.length);
                      final names = values.docs
                          .map((doc) => doc['groupName'])
                          .toSet()
                          .toList();
                      return ListView.builder(
                        itemCount: names.length,
                        itemBuilder: (context, index) {
                          final lastMessage =
                              DoctorCubit.get(context).getLastMessageFromSender(
                            values.docs
                                .map(
                                    (doc) => doc.data() as Map<String, dynamic>)
                                .toList(),
                            names[index],
                            index,
                          );
                          DateTime time = DateTime.fromMillisecondsSinceEpoch(
                              (lastMessage["time"].seconds * 1000 +
                                      lastMessage["time"].nanoseconds / 1000000)
                                  .toInt());
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SupportChatScreen(
                                          userEmail: names[index]),
                                    ));
                              },
                              child: Container(
                                width: 1.sw,
                                height: 60.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff284448), width: 2),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            names[index],
                                            style: GoogleFonts.prompt(
                                                fontSize: 16.w,
                                                color: Color(0xff232425)),
                                          ),
                                          Text(
                                            "${DateFormat('MMMM d').format(time)}",
                                            style: GoogleFonts.prompt(
                                                fontSize: 14.w,
                                                color: Color(0xff8c8c8c)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(width: 0.6.sw,
                                            child: Text(
                                              lastMessage["text"],overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.prompt(
                                                  fontSize: 16.w,
                                                  color: Color(0xff8c8c8c)),
                                            ),
                                          ),
                                          Text(
                                            "${DateFormat.jm().format(time)}",
                                            style: GoogleFonts.prompt(
                                                fontSize: 14.w,
                                                color: Color(0xff8c8c8c)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.prompt(
                              fontSize: 18.sp, color: Color(0xff232425)),
                        )
                      ],
                    );
                  }));
        },
      );
    }
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        activeColor: Color(0xff86E3EF),
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
          TabItem(
              icon: Icons.settings_outlined, activeIcon: Icon(Icons.settings)),
        ],
        initialActiveIndex: _activeIndex,
        onTap: (int i) async => {
          if (i == 2)
            {
              await XrayCubit.get(context).chooseUserXray(),
              setState(() => _activeIndex = i)
            }
          else
            {setState(() => _activeIndex = i)}
        },
      ),
      body: IndexedStack(
        index: _activeIndex,
        children: [
          Scaffold(
            appBar: AppBar(
              actions: [
                IconButton.outlined(style: ButtonStyle(side: MaterialStatePropertyAll(BorderSide(color:Color(0xff7bc3cd)))),
                    onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackScreen(),));
                    },
                    icon: Icon(
                      Icons.feedback_outlined,
                      color: Color(0xff12696f),
                    ))
              ],
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: GradientText("BoneVision",
                  style: GoogleFonts.skranji(fontSize: 18.sp),
                  gradient: LinearGradient(
                      colors: [Color(0xff7bc3cd), Color(0xff3e6267)])),
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        width: 1.sw,
                        height: 200.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 1.sw,
                              decoration: BoxDecoration(
                                  color: Color(0xff7bc3cd),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 12.0.w),
                                child: Text("Last Uploaded",
                                    style: GoogleFonts.prompt(
                                        fontSize: 20.w, color: Colors.white)),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: tests.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: 125.h,
                                      height: 40.h,
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 50.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xff12696f)),
                    width: 1.sw,
                    height: 100.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.0.w, top: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                                "Have you talked to one of our doctors yet?",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.prompt(
                                    fontSize: 12.w, color: Color(0xfffafafa))),
                          ),
                          Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SupportChatScreen(),
                                        ));
                                  },
                                  child: Text(
                                    "Click Here to Start Now!",
                                    style: GoogleFonts.prompt(
                                        color: Color(0xffacfbff)),
                                  )))
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(style: BorderStyle.none),
                          color: Color(0xff284448),
                        ),
                        width: 1.sw,
                        height: 40.h,
                        child: Center(
                          child: Text("Start Uploading your X-Rays!",
                              style: GoogleFonts.prompt(
                                  fontSize: 14.w, color: Color(0xfffafafa))),
                        ),
                      ),
                      CustomPaint(
                        size: Size(30, 30), // Specify the size of the widget
                        painter: CurvedTrianglePainter(),
                      ),
                    ],
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

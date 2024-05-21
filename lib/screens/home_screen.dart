import 'package:bonevision/bloc/doctor/doctor_cubit.dart';
import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/bloc/xray/xray_cubit.dart';
import 'package:bonevision/component/clipcontainer.dart';
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
                                          Text(
                                            lastMessage["text"],
                                            style: GoogleFonts.prompt(
                                                fontSize: 16.w,
                                                color: Color(0xff8c8c8c)),
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
              automaticallyImplyLeading: false,
              title: Text("Hey! Welcome ${cubit.userName ?? ""}",
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
                  // cubit.file != null
                  //     ? Container(
                  //         margin: EdgeInsets.symmetric(vertical: 20.h),
                  //         width: 320.w,
                  //         height: 220.h,
                  //         child: Image.file(
                  //           File(cubit.file!.path),
                  //           fit: BoxFit.fitHeight,
                  //         ),
                  //       )
                  //     : Container(
                  //         margin: EdgeInsets.symmetric(vertical: 20.h),
                  //         width: 340.w,
                  //         height: 220.h,
                  //         color: Colors.grey[200],
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Icon(
                  //               Icons.image_search_rounded,
                  //               color: Colors.grey[400],
                  //               size: 150.w,
                  //             ),
                  //             Text("UPLOAD IMAGE",
                  //                 style: TextStyle(
                  //                     fontSize: 20.w,
                  //                     color: Colors.grey[400],
                  //                     fontWeight: FontWeight.w500))
                  //           ],
                  //         ),
                  //       ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
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
                  ),
                  Column(
                    children: [
                      Container(
                        width: 1.sw,
                        height: 150.h,
                        color: Color(0xff87e3f2),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12.0.w),
                              child: Text("Start Uploading your X-Rays!",
                                  style: GoogleFonts.prompt(
                                      fontSize: 20.w,
                                      color: Color(0xff232425))),
                            )
                          ],
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

class UpwardTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xff232425)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

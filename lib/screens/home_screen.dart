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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeIndex = 0;
  List tests = [1, 2, 3];
  String doctorIcon =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48"><g fill="currentColor" fill-rule="evenodd" clip-rule="evenodd"><path d="m16.649 9.326l.055-.24c.105-.446.277-1.102.632-1.748c.362-.658.923-1.325 1.803-1.764c.877-.437 1.976-.6 3.335-.42c1.5.2 4.513.696 7.175 2.05c2.677 1.362 5.185 3.705 5.185 7.607c0 2.016-.78 4.179-1.536 5.589c-.363.678-.794 1.326-1.226 1.675c-.099.08-.24.18-.415.25a8.004 8.004 0 0 1-15.05.738l-.024.004l-.355-.431L17 22l-.772.636l-.001-.002l-.002-.002l-.005-.007l-.017-.02a7 7 0 0 1-.247-.327a14 14 0 0 1-.61-.924c-.47-.778-1.037-1.886-1.4-3.179c-.362-1.293-.528-2.809-.148-4.373c.37-1.522 1.243-3.02 2.824-4.358zm1.68 12.638a6.003 6.003 0 0 0 11.564-.833l.113.038a2 2 0 0 1-.006-.17c0-1.655-.23-2.81-.444-3.53a7 7 0 0 0-.139-.416l-.041.002h-.04a11.5 11.5 0 0 1-2.232-.17c-1.717-.29-4.042-1.014-6.78-2.691q-.09.201-.18.453c-.196.555-.357 1.214-.496 1.91c-.123.613-.224 1.23-.32 1.808l-.037.228c-.103.62-.206 1.229-.326 1.67c-.21.766-.424 1.31-.636 1.7m-1.4-1.863a11 11 0 0 1-1.056-2.465c-.299-1.066-.409-2.22-.131-3.361c.27-1.11.923-2.277 2.266-3.383c.242-.164.352-.384.382-.443v-.001a2 2 0 0 0 .126-.337c.032-.114.067-.27.1-.41l.035-.157c.095-.403.218-.842.438-1.243c.214-.388.507-.72.943-.937c.438-.219 1.116-.369 2.178-.227c1.453.193 4.186.656 6.532 1.85c2.33 1.185 4.092 2.979 4.092 5.824c0 1.31-.44 2.8-.97 3.975c-.1-.766-.244-1.392-.392-1.888a8 8 0 0 0-.385-1.037a5 5 0 0 0-.19-.365l-.017-.027l-.006-.01l-.003-.005l-.002-.003l-.84.54l.84-.54l-.37-.574l-.662.133l-.014.003l-.097.013a5 5 0 0 1-.448.03a9.5 9.5 0 0 1-1.84-.144c-1.613-.272-3.983-1.013-6.862-2.93l-.7-.467l-.579.61c-.477.502-.801 1.187-1.038 1.854c-.242.685-.425 1.45-.572 2.184a53 53 0 0 0-.332 1.88l-.038.224c-.107.651-.194 1.148-.282 1.47q-.054.199-.106.364m13.881.422l.004-.002zm.004-.002l-.004.002z"/><path d="M17.914 28.855c-.212-.422-.473-.943-.914-.842c-5.404 1.23-11 4.781-11 8.557V42h36v-5.43c0-2.974-3.472-5.809-7.587-7.48l-.005-.01l-.014-.027l-.033.016c-1.093-.44-2.231-.8-3.361-1.056c-.503-.115-1.023.577-1.25 1.01H18zm13.489 1.32q.656.182 1.301.407c.012.342-.014.746-.07 1.158a8 8 0 0 1-.272 1.26H31a1 1 0 0 0-.894.553l-1 2A1 1 0 0 0 29 36v2a1 1 0 0 0 1 1h2v-2h-1v-.764L31.618 35h2.764L35 36.236V37h-1v2h2a1 1 0 0 0 1-1v-2a1 1 0 0 0-.106-.447l-1-2A1 1 0 0 0 35 33h-.566a11 11 0 0 0 .248-1.609c.975.461 1.881.99 2.666 1.562C39.27 34.355 40 35.667 40 36.57V40H8v-3.43c0-.903.73-2.215 2.652-3.617c.966-.705 2.119-1.343 3.355-1.871a10.2 10.2 0 0 0 .381 2.354l.008.028a3 3 0 1 0 1.956-.444l-.044-.144a8 8 0 0 1-.235-1.136a7 7 0 0 1-.07-1.171q.005-.126.015-.224q.18-.056.36-.107l.415.786h14.164zM16 37.016c.538 0 1-.44 1-1.015c0-.574-.462-1.015-1-1.015s-1 .44-1 1.015c0 .574.462 1.015 1 1.015"/></g></svg>';
  String doctorIconFill =
      '<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 48 48"><g fill="currentColor"><path fill-rule="evenodd" d="M33.834 13.81c0 3.461-.86 7.975-2.183 7.29a8.001 8.001 0 0 1-15.611-1.54c-1.313-2.297-3.035-6.9 1.392-10.488c.08-.026.128-.242.2-.56c.274-1.203.881-3.877 4.71-3.366c2.953.393 11.492 1.918 11.492 8.665m-3.806 2.182s-.452 1.322-.028 2.795a6 6 0 0 1-11.996.197c.145-.55.145-1.481.144-2.516c-.001-1.867-.003-4.07.852-4.968c5.989 3.989 11.028 4.492 11.028 4.492" clip-rule="evenodd"/><path d="M13 36c0-1.082.573-2.03 1.433-2.558a12 12 0 0 1-.092-.375a22 22 0 0 1-.355-2.068a20 20 0 0 1-.155-2.006C9.61 30.65 6 33.538 6 36.57V42h36v-5.43c0-2.904-3.31-5.675-7.298-7.36v.028c.018.61-.016 1.31-.082 1.983c-.06.624-.149 1.246-.256 1.779H35a1 1 0 0 1 .894.553l1 2c.07.139.106.292.106.447v2a1 1 0 0 1-1 1h-2v-2h1v-.764L34.382 35h-2.764L31 36.236V37h1v2h-2a1 1 0 0 1-1-1v-2c0-.155.036-.308.106-.447l1-2A1 1 0 0 1 31 33h1.315q.033-.129.066-.286c.1-.471.189-1.068.249-1.685c.06-.618.088-1.231.073-1.735a5 5 0 0 0-.049-.624c-.022-.142-.044-.207-.048-.221q-.002-.005 0-.002l.003-.001A22 22 0 0 0 31 28.013c-.503-.115-1.023.577-1.25 1.01H18l-.086-.168c-.212-.422-.473-.943-.914-.842q-.578.131-1.155.297a7 7 0 0 0-.016.527c.004.553.057 1.23.142 1.914c.085.682.2 1.346.32 1.87q.052.227.1.404A3 3 0 1 1 13 36"/><path d="M17 36c0 .574-.462 1.015-1 1.015s-1-.44-1-1.015c0-.574.462-1.015 1-1.015s1 .44 1 1.015"/></g></svg>';

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
              body: Center(child: ElevatedButton(onPressed: ()async{
                DoctorCubit.get(context).listenToDocumentIdsAfterMessages();
          }, child: Text("Get IDS")),));
              // FutureBuilder(
              //   future: DoctorCubit.get(context).getDocumentIdsAfterMessages(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Center(
              //         child:
              //             CircularProgressIndicator(), // Show a loading indicator
              //       );
              //     } else if (snapshot.hasError) {
              //       return Center(
              //         child: Text(
              //             'Error: ${snapshot.error}'), // Show an error message
              //       );
              //     } else {
              //       return SizedBox();
              //       // print(snapshot.data);
              //       // List<String> documentIds = snapshot.data!;
              //       // return ListView.builder(
              //       //   itemCount: documentIds.length,
              //       //   itemBuilder: (context, index) {
              //       //     return ListTile(
              //       //       title: Text(documentIds[
              //       //           index]), // Display document IDs in a list
              //       //     );
              //       //   },
              //       // );
              //     }
              //   },
              // ));
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
              icon: Iconify(
                doctorIcon,
                color: Colors.white,
              ),
              activeIcon: Iconify(
                doctorIconFill,
                color: Color(0xff86E3EF),
              )),
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
                IconButton.outlined(
                    style: ButtonStyle(
                        side: MaterialStatePropertyAll(
                            BorderSide(color: Color(0xff7bc3cd)))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackScreen(),
                          ));
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
                        border: Border.all(color: Color(0xff12696f))),
                    width: 1.sw,
                    height: 120.h,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 12.0.w, top: 12.h, right: 12.0.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                      color: Color(0xff7bc3cd).withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(999)),
                                  child: Icon(
                                    size: 24,
                                    Icons.message,
                                    color: Color(0xff028dff),
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Have a Medical Question?",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.prompt(
                                          fontSize: 14.sp,
                                          color: Color(0xff5a5a5a),
                                          fontWeight: FontWeight.w600)),
                                  Text(
                                      "Submit your medical question and receive\nan answer from a specialized doctor",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.prompt(
                                        fontSize: 10.sp,
                                        color: Color(0xff8a8a8a),
                                      ))
                                ],
                              ),
                            ],
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SupportChatScreen()));
                            },
                            child: Text("Ask Now",
                                style: GoogleFonts.prompt(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff028dff),
                                )),
                            style: ButtonStyle(
                                fixedSize:
                                    WidgetStatePropertyAll(Size(1.sw, 30.h)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor: WidgetStatePropertyAll(
                                    Color(0xff7bc3cd).withOpacity(0.4))),
                          )
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
                        size: Size(30, 30),
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

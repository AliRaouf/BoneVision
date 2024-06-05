import 'dart:convert';
import 'dart:developer';

import 'package:bonevision/bloc/xray/xray_cubit.dart';
import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/screens/response_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
class UploadTestScreen extends StatefulWidget {
  const UploadTestScreen({super.key});

  @override
  State<UploadTestScreen> createState() => _UploadTestScreenState();
}
class _UploadTestScreenState extends State<UploadTestScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = XrayCubit.get(context);
    return BlocBuilder<XrayCubit, XrayState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomAppBar(color: Colors.white,
            elevation: 0,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(sColor: Color(0xff87e3f2),
                    screenWidth: 140.w,
                    screenHeight: 60.h,
                    text: "Replace",
                    onpressed: () async{
                     await cubit.chooseUserXray().then((value) => setState(() {

                     }));

                    },
                    bColor: Colors.white,
                    tColor: Color(0xff232425),
                    fontSize: 14.sp,
                    radius: 15),
                CustomButton(
                    screenWidth: 140.w,
                    screenHeight: 60.h,
                    text: "Continue",
                    onpressed: ()async{
                      // final img.Image? originalImage = img.decodeImage(cubit.image!);
                      // final img.Image resizedImage = img.copyResize(originalImage!, width: 640, height: 640);
                      // cubit.resizedImage = Uint8List.fromList(img.encodeJpg(resizedImage));
                      cubit.resizedImage = cubit.image!;
                      String base64Image = base64Encode(cubit.resizedImage!);
                      final apiKey = 'PJ8OjvRxM1f1W929Ksq7';
                      final url = 'https://detect.roboflow.com/bone-od/7?api_key=$apiKey';

                      final headers = {
                        'Content-Type': 'application/x-www-form-urlencoded',
                      };

                      final response = await post(Uri.parse(url),
                          headers: headers,
                          body: "");

                      if (response.statusCode == 200) {
                        log(response.body);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ResponseImage()));
                      } else {
                        print('Error: ${response.statusCode}');
                        print(response.body);
                      }
                    },
                    bColor: Color(0xff87e3f2),
                    tColor: Color(0xff232425),
                    fontSize: 14.sp,
                    radius: 15)
              ],
            ),
          ),
          body: cubit.image == null
              ? Center(
            child: Text(
              "Please Select an Xray",
              style: GoogleFonts.prompt(),
            ),
          )
              : SafeArea(
                        child: Image(
                          image: MemoryImage(cubit.image!),
                          fit: BoxFit.fill,
            )
          ),
        );
      },
    );
  }
}

import 'package:bonevision/bloc/xray/xray_cubit.dart';
import 'package:bonevision/component/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          bottomNavigationBar: BottomAppBar(
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
                    onpressed: () {},
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
            child: Column(
              children: [Container(height: 0.8.sh,
                  child: Center(child: Image.memory(cubit.image!)))],
            ),
          ),
        );
      },
    );
  }
}

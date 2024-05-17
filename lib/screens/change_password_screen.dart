import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/component/custom_form_text_field.dart';
import 'package:bonevision/component/triangle.dart';
import 'package:bonevision/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ChangeUserPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password Changed Successfully")));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context)=>const LoginScreen()));
        }else if (state is ChangeUserPasswordErrorState){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed To Change Password")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        child: Container(
                          color: Color(0xff86E3EF),
                          width: 360.w, height: 200.h,
                        ), clipper: Triangle(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 12),
                        child: IconButton.outlined(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back)),
                      ),
                    ],
                  ),
                  Container(width: 0.9.sw, height: 300.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextFormField(readOnly: false,
                          hint: "Current Password",
                          label: "Current Password",
                          obscureText: true,
                          controller: currentPasswordController,),
                        CustomTextFormField(readOnly: false,
                          hint: "New Password",
                          label: "New Password",
                          obscureText: true,
                          controller: newPasswordController,),
                        CustomTextFormField(readOnly: false,
                          validate: (data) {
                            if (confirmPasswordController.text !=
                                newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          hint: "Confirm Password",
                          label: "Confirm Password",
                          obscureText: true,
                          controller: confirmPasswordController,),
                        CustomButton(screenWidth: .4.sw,
                            screenHeight: 40.h,
                            text: "Confirm",
                            onpressed: () {
                              cubit.changeUserPassword(
                                  currentPasswordController.text,
                                  newPasswordController.text);
                            },
                            bColor: Color(0xff86E3EF),
                            tColor: Color(0xff232425),
                            fontSize: 16.sp,
                            radius: 15)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

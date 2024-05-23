import 'package:bonevision/bloc/login/login_cubit.dart';
import 'package:bonevision/bloc/register_cubit.dart';
import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/component/custom_form_text_field.dart';
import 'package:bonevision/screens/forgot_password_screen.dart';
import 'package:bonevision/screens/home_screen.dart';
import 'package:bonevision/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordObscured = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          await UserCubit.get(context).getUserData();
          await UserCubit.get(context).receiverUserData();
          RegisterCubit.get(context)
              .showSnackBar(context, "Logged in Successfully");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (state is LoginErrorState) {
          RegisterCubit.get(context)
              .showSnackBar(context, cubit.error.toString());
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 1.sw,
                    height: 200.h,
                    child: Image.asset("assets/images/3.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Bone',
                            style: GoogleFonts.prompt(
                                color: Color(0xff97dfe3),
                                fontWeight: FontWeight.w700,
                                fontSize: 35.w),
                          ),
                          TextSpan(
                            text: 'Vision',
                            style: GoogleFonts.prompt(
                                color: Color(0xffa9a9a9),
                                fontWeight: FontWeight.w700,
                                fontSize: 35.w),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 0.8.sw,
                    margin: EdgeInsets.symmetric(vertical: 12.5.h),
                    child: CustomTextFormField(
                      hint: "Email",
                      controller: emailController,
                      label: "Email",
                      obscureText: false,
                      readOnly: false,
                    ),
                  ),
                  Container(
                    width: 0.8.sw,
                    margin: EdgeInsets.only(bottom: 12.5.h),
                    child: CustomTextFormField(
                      hint: "Password",
                      controller: passwordController,
                      label: "Password",
                      obscureText: _isPasswordObscured,
                      icon: IconButton(
                          onPressed: () {
                            setState(() {
                              _togglePasswordVisibility();
                            });
                          },
                          icon: Icon(_isPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      iconColor:
                          _isPasswordObscured ? Color(0xff38a7ab) : Colors.grey,
                      readOnly: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: CustomButton(
                        screenWidth: 0.4.sw,
                        screenHeight: 45.h,
                        text: "Login",
                        onpressed: () {
                          cubit.signInWithEmail(
                              emailController.text, passwordController.text);
                        },
                        bColor: Color(0xff97dfe3),
                        tColor: Color(0xff232425),
                        fontSize: 18.w,
                        radius: 20),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen()));
                },
                child: Text(
                  "Forgot your password?",
                  style: GoogleFonts.prompt(
                      color: Color(0xff284448), fontSize: 14.w),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: GFIconButton(
                        size: 40,
                        onPressed: () async {
                          try {
                            final user = await cubit.signInWithFacebook();
                            print(user!.email);
                            await cubit.doesEmailExist(user.email!);
                            if (cubit.isExist == true) {
                              await UserCubit.get(context).getUserData();
                              await UserCubit.get(context).receiverUserData();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else if (cubit.isExist == false) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen(
                                            user: user,
                                          )));
                            }
                          } on FirebaseAuthException catch (error) {
                            print(error.message);
                          } catch (e) {
                            print(e);
                          }
                        },
                        icon: Icon(Icons.facebook),
                        shape: GFIconButtonShape.circle),
                  ),
                  Container(
                    child: GFIconButton(
                        size: 40,
                        borderShape:
                            CircleBorder(side: BorderSide(color: Colors.black)),
                        onPressed: () async {
                          try {
                            final user = await cubit.googleSignin();
                            print(user!.email);
                            await cubit.doesEmailExist(user.email!);
                            if (cubit.isExist == true) {
                              await UserCubit.get(context).getUserData();
                              await UserCubit.get(context).receiverUserData();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
                            } else if (cubit.isExist == false) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen(
                                            user: user,
                                          )));
                            }
                          } on FirebaseAuthException catch (error) {
                            print(error.message);
                          } catch (e) {
                            print(e);
                          }
                        },
                        type: GFButtonType.outline,
                        icon: SvgPicture.network(
                            "https://upload.wikimedia.org/wikipedia/commons/c/c1/Google_%22G%22_logo.svg"),
                        shape: GFIconButtonShape.circle),
                  ),
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}

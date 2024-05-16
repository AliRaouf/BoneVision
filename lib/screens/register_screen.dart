import 'package:bonevision/bloc/login/login_cubit.dart';
import 'package:bonevision/bloc/register_cubit.dart';
import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/component/custom_form_text_field.dart';
import 'package:bonevision/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key,this.user});
  User? user;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordObscured = true;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var genderController = TextEditingController();
  var dateController = TextEditingController();
  DateTime? date;
  List<DropdownMenuEntry<String>> genders = [
    const DropdownMenuEntry(value: "Male", label: "Male"),
    const DropdownMenuEntry(value: "Female", label: "Female"),
  ];
  late MemoryImage? _selectedImage;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }
@override
  void initState() {
    if(LoginCubit.get(context).isExist==false){
      emailController.text=widget.user?.email?? "";
      usernameController.text=widget.user?.displayName??"";
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          cubit.showSnackBar(context, "Account Created Successfully");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else if (state is RegisterErrorState) {
          cubit.showSnackBar(context, state.error.toString());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: ListView(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: 1.sw, height: 180.h,
                  child: Image.asset("assets/images/3.png"),),
                  Padding(
                    padding: EdgeInsets.all(16.0),
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
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: CustomTextFormField(
                      hint: "UserName",
                      controller: usernameController,
                      label: "UserName",
                      obscureText: false,
                      readOnly: LoginCubit.get(context).isExist==false?true:false,
                    ),
                  ),
                  Container(
                    width: 0.8.sw,
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: CustomTextFormField(
                      hint: "Email",
                      controller: emailController,
                      label: "Email",
                      obscureText: false,
                      readOnly: LoginCubit.get(context).isExist==false?true:false,
                    ),
                  ),
                  Container(
                    width: 0.8.sw,
                    margin: EdgeInsets.only(bottom: 15.h),
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
                  DropdownMenu<String>(
                      width: 0.8.sw,
                      inputDecorationTheme: InputDecorationTheme(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          constraints:
                          BoxConstraints(maxHeight: 42.5.h),
                          contentPadding:
                           EdgeInsets.symmetric(horizontal: 10.w),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                              const BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                              const BorderSide(color: Colors.black))),
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Gender",
                          style: GoogleFonts.prompt(
                              fontSize: 18, color: const Color(0xff38a7ab)),
                        ),
                      ),
                      controller: genderController,
                      dropdownMenuEntries: genders,
                      onSelected: (value) {
                        genderController.text = value!;
                        print(genderController.text);
                      }),
                  Container(
                    width: 0.8.sw,
                    margin: EdgeInsets.only(top: 15.h),
                    child: CustomTextFormField(controller: dateController,
                        icon: IconButton(
                            onPressed: () async {
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1930),
                                  lastDate: DateTime(2014));
                              if (date != null) {
                                dateController.text =
                                    DateFormat('d/M/yyyy').format(date!);
                              }
                            },
                            icon: Icon(Icons.date_range,
                                color: Color(0xff38a7ab))),
                        readOnly: true,
                        hint: "31/1/2001",
                        label: "DateOfBirth",
                        obscureText: false),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35.h),
                    child: CustomButton(
                        screenWidth: 0.8.sw,
                        screenHeight: 45.h,
                        text: "Register",
                        onpressed: () {
                          if (LoginCubit.get(context).isExist==false) {
                            cubit.saveUser(
                                emailController.text, passwordController.text, usernameController.text, genderController.text,
                                date);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                          }else{
                            cubit.registerUser(
                                emailController.text, passwordController.text, usernameController.text, genderController.text,
                                date);
                          }
                        },
                        bColor: Color(0xff97dfe3),
                        tColor: Color(0xff232425),
                        fontSize: 32.w,
                        radius: 20),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.prompt(
                        color: Color(0xff232425), fontSize: 18.w),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.prompt(fontWeight:FontWeight.w700,
                          color: Color(0xff38a7ab),
                          fontSize: 20.w),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    ),
                  )
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}

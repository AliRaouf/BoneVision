import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/component/custom_button.dart';
import 'package:bonevision/component/custom_form_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

late MemoryImage? _selectedImage;

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    TextEditingController userNameController =
        TextEditingController(text: cubit.userName ?? "");
    TextEditingController genderController =
        TextEditingController(text: cubit.gender ?? "");
    TextEditingController ageController = TextEditingController(
        text:
            "${cubit.calculateAge(cubit.timestampToDateTime(cubit.date ?? Timestamp.fromMicrosecondsSinceEpoch(100000)))} Years");
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(children: [
                Center(
                    child: Container(
                  child: cubit.image != null
                      ? CircleAvatar(
                          radius: 64.r,
                          backgroundImage: MemoryImage(cubit.image!),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 64.r,
                          backgroundImage: NetworkImage(cubit.profileImage == ''
                              ? "https://static.thenounproject.com/png/4035892-200.png"
                              : cubit.profileImage!),
                        ),
                )),
                Positioned(
                    bottom: 0,
                    left: 205.w,
                    child: IconButton(
                        onPressed: () {
                          cubit.changeUserImage().then((image) {
                            setState(() {
                              _selectedImage = image;
                            });
                          });
                        },
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.black87,
                        )))
              ]),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 300.w,
                child: CustomTextFormField(
                  readOnly: false,
                  hint: "UserName",
                  label: "UserName",
                  obscureText: false,
                  controller: userNameController,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                  screenWidth: 100.w,
                  screenHeight: 50.h,
                  text: "Edit",
                  onpressed: ()async{
                    if(cubit.image != null){
                     String imageUrl = await cubit.uploadImage(cubit.image!, cubit.user!.email);
                     cubit.updateUserImage(imageUrl);
                     cubit.updateUserData(userNameController.text);
                    await cubit.receiverUserData();
                     cubit.userSignOut(context);
                    }
                    else{
                    await  cubit.updateUserData(userNameController.text);
                    await cubit.receiverUserData();
                    cubit.userSignOut(context);
                    }
                  },
                  bColor: Color(0xff87e3f2),
                  tColor: Colors.black,
                  fontSize: 16.sp,
                  radius: 15)
            ],
          ),
        ),
      ),
    );
  }
}

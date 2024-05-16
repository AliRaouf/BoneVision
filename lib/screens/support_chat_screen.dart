import 'package:bonevision/bloc/help_center/helpcenter_cubit.dart';
import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/component/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  @override
  void initState() {
    HelpcenterCubit.get(context).getUserData();
    HelpcenterCubit.get(context)
        .receiveMessage(UserCubit.get(context).user!.email!);
    super.initState();
  }
  var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = HelpcenterCubit.get(context);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xff21be44),
      title: Text("Doctor",style: GoogleFonts.prompt(color:Color(0xffFAFAFA)),),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          cubit.messagesStream != null // Check if messagesStream is not null
              ? ChatList(
            messageStream: cubit.messagesStream!,
            userMail: cubit.user!.email!,
          )
              : CircularProgressIndicator(),
          // Show CircularProgressIndicator if messagesStream is null
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.95,
                child: TextFormField(
                  controller: messageController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        DateTime time = DateTime.now();
                        cubit.sendMessage(
                          messageController.text,
                          time,
                          cubit.user!.email!,
                        );
                        messageController.clear();
                      },
                      icon: Icon(Icons.send, color: Color(0xff21be44)),
                    ),
                    hintText: 'Send a Message',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xff21be44), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xff21be44), width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
}}

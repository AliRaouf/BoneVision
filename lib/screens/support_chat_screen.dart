import 'package:bonevision/bloc/help_center/helpcenter_cubit.dart';
import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/component/chat_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportChatScreen extends StatefulWidget {
  SupportChatScreen({super.key, this.userEmail});

  String? userEmail;

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  @override
  void initState() {
    if (UserCubit
        .get(context)
        .type == 'doctor') {
      HelpcenterCubit.get(context)
          .receiveMessage(widget.userEmail!);
    }
    else {
      HelpcenterCubit.get(context).getUserData();
      HelpcenterCubit.get(context)
          .receiveMessage(UserCubit
          .get(context)
          .user!
          .email!);
    }
    super.initState();
  }

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cubit = HelpcenterCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ee1e6),
        title: Text(
          "Doctor", style: GoogleFonts.prompt(color: Color(0xff232425)),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff232425),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          cubit.messagesStream != null // Check if messagesStream is not null
              ? ChatList(
            messageStream: cubit.messagesStream!,
            userMail: FirebaseAuth.instance.currentUser!.email!,
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
                      onPressed: () async {
                        if (messageController.text.isNotEmpty) {
                          if (await cubit.getLastMessageTimestamp(
                              cubit.user!.email!)) {
                            DateTime time = DateTime.now();
                            cubit.sendMessage(
                              messageController.text,
                              time,cubit.user!.email!,
                              UserCubit
                                  .get(context)
                                  .type == 'doctor' ? widget.userEmail! : cubit
                                  .user!.email!,
                            );
                            messageController.clear();
                            cubit.sendMessage(
                                'Thank you for reaching out! we have received your message and will respond to you as soon as possible.',
                                DateTime.now(),"Generated",cubit.user!.email!);
                            print("Generation");
                          }
                          else{
                            DateTime time = DateTime.now();
                            cubit.sendMessage(
                              messageController.text,
                              time,cubit.user!.email!,
                              UserCubit
                                  .get(context)
                                  .type == 'doctor' ? widget.userEmail! : cubit
                                  .user!.email!,
                            );
                            messageController.clear();
                            print("No generation");
                          }
                        }
                      },
                      icon: Icon(Icons.send, color: Color(0xff284448)),
                    ),
                    hintText: 'Send a Message',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Color(0xff284448), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Color(0xff284448), width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

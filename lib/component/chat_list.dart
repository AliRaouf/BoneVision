import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.messageStream, required this.userMail});
  final Stream messageStream;
  final String userMail;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: messageStream, builder: (context,snapshot){
      if (snapshot.hasData){
        QuerySnapshot values=snapshot.data as QuerySnapshot;
        return Expanded(child: ListView.builder(
            physics: BouncingScrollPhysics()
            ,itemCount: values.docs.length,
            itemBuilder: (context, index) {
              return Align(alignment:
              values.docs[index]["sender"]==userMail?
              Alignment.centerRight:Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8),child:
                Container(
                  padding: EdgeInsets.all(8),

                  decoration:
                  values.docs[index]["sender"]==userMail?
                  BoxDecoration(borderRadius:
                  BorderRadius.only(topLeft:Radius.circular(30),bottomLeft: Radius.circular(30)
                      ,topRight: Radius.circular(30)
                  ),color: Color(0xff00a228)
                  ):BoxDecoration(borderRadius:
                  BorderRadius.only(topLeft:Radius.circular(30),bottomRight: Radius.circular(30)
                      ,topRight: Radius.circular(30)
                  ),color: Colors.grey[800]
                  ),child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 8),
                    child: Text(values.docs[index]["sender"]=="amr2082002@gmail.com"?"Doctor":
                      values.docs[index]["sender"],style: GoogleFonts.prompt(color: Color(
                        0xffe7e7e7)),),
                  ),
                  Text(values.docs[index]["text"],style: GoogleFonts.prompt(color: Color(0xfffafafa),fontWeight: FontWeight.bold),)
                ]),
                ),
                ),
              );
            }

        )
        );
      }else{
        const Center(
          child:
          Text('Data is empty'),
        );
      }

      return Container();
    } );
  }
}
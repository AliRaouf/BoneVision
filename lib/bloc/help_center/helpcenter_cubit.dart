import 'package:bloc/bloc.dart';
import 'package:bonevision/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'helpcenter_state.dart';

class HelpcenterCubit extends Cubit<HelpcenterState> {
  HelpcenterCubit() : super(HelpcenterInitial());
  static HelpcenterCubit get(context)=>BlocProvider.of(context);
  String? userEmail;
  Stream ?messagesStream;
  User? user;
  sendMessage(String text,DateTime time,String mail,String groupName){
    userEmail=FirebaseAuth.instance.currentUser!.email;
    emit(MessageSendLoadingState());
    Message message= Message(text: text, time: DateTime.now(), sender: mail, groupName:groupName);
    FirebaseFirestore.instance.collection("messages").add(message.toMap()).
    then((value){
      emit(MessageSendSuccessState());
    }).
    catchError((error) {
      emit(MessageSendErrorState()
      );
      print(error);
    });
  }
  receiveMessage(String groupName){
    messagesStream=FirebaseFirestore.instance.collection("messages").where("groupName",isEqualTo:groupName).orderBy("time").snapshots();
    emit(MessageReceiveMessageState());
  }
  Future<bool> getLastMessageTimestamp(String userEmail) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('messages')
          .where('sender', isEqualTo: userEmail)
          .orderBy('time', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Timestamp lastMessageTimestamp =  querySnapshot.docs.first['time'];
        DateTime lastMessageTime = lastMessageTimestamp.toDate();
        Duration timeDifference = DateTime.now().difference(lastMessageTime);
        return timeDifference.inHours >= 12;
      } else {
        // No messages found for the user
        return true;
      }
    } catch (e) {
      // Error occurred while fetching data
      print('Error fetching last message timestamp: $e');
      return false;
    }
  }
  getUserData()
  {
    user=FirebaseAuth.instance.currentUser;
    emit(MessageGetUserDataState());
  }
}

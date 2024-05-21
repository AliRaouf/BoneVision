import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
 static DoctorCubit get(context) => BlocProvider.of(context);
  Stream? messagesStream;
  receiveMessage(){
    messagesStream=FirebaseFirestore.instance.collection("messages").where("sender" ).snapshots();
    emit(MessageReceiveMessageState());
  }
  Map<String, dynamic> getLastMessageFromSender(List<Map<String, dynamic>> messages, String name, int index) {
    List<Map<String, dynamic>> filteredMessages = messages
        .where((message) => message["sender"] == messages[index]["sender"])
        .toList();
    filteredMessages.sort((a, b) => b["time"].compareTo((a["time"])));
    return filteredMessages.first;
  }
}

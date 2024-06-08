import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());
 static DoctorCubit get(context) => BlocProvider.of(context);
  Stream? messagesStream;
  Future<List<String>> getDocumentIds() async {
    List<String> documentIds = [];

    CollectionReference messagesCollection =
    FirebaseFirestore.instance.collection("messages");

    QuerySnapshot querySnapshot = await messagesCollection.get();
    print(querySnapshot.docs);

    // Extract document IDs
    querySnapshot.docs.forEach((doc) {
      documentIds.add(doc.id);
    });

    return documentIds;
  }
  receiveMessage(){
    messagesStream=FirebaseFirestore.instance.collection("messages").snapshots();
    emit(MessageReceiveMessageState());
  }
  Map<String, dynamic> getLastMessageFromSender(List<Map<String, dynamic>> messages, String name, int index) {
    List<Map<String, dynamic>> filteredMessages = messages
        .where((message) => message["sender"] == messages[index]["sender"])
        .toList();
    filteredMessages.sort((a, b) => b["time"].compareTo((a["time"])));
    return filteredMessages.first;
  }
  void listenToDocumentIdsAfterMessages() {
    // Reference to the "messages" collection
    CollectionReference messagesRef = FirebaseFirestore.instance.collection('messages');

    // Stream that listens for changes in the "messages" collection
    StreamSubscription<QuerySnapshot> subscription = messagesRef.snapshots().listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print(doc.id); // This will print the ID of each document
      });
    });

    // Don't forget to cancel the subscription when it's no longer needed
    // For example, you can cancel it in the dispose() method of a StatefulWidget
    // or when you navigate away from the page where you're listening to changes
    // subscription.cancel();
  }
}

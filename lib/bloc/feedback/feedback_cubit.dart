import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());
  static FeedbackCubit get(context) => BlocProvider.of(context);
  saveFeedback(BuildContext context, Map<String, dynamic> Feedback) {
    emit(SaveFeedBackLoading());
    try {
      FirebaseFirestore.instance
          .collection("Feedbacks")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection("userFeedback")
          .add(Feedback);
      emit(SaveFeedBackSuccess());
    } catch (e) {
      emit(SaveFeedBackError());
    }
  }
}

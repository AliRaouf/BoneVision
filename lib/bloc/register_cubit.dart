

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  String error="";

  registerUser(String email, String password,String userName, String gender,date) async {
    emit(RegisterLoadingState());
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
        saveUser(email, password, userName, gender,date);
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        error=('An account already exists for that email.');
        emit(RegisterErrorState(error));
      } else if (e.code == 'weak-password') {
        error=('The password provided is too weak.');
        emit(RegisterErrorState(error));
      } else {
        error=e.message!;
        emit(RegisterErrorState(error));
      }
    } catch (e) {
      print(e);
      emit(RegisterErrorState(e));
    }
  }

  saveUser(email, password, username, gender,date)async{
    emit(SaveUserLoadingState());
    try {
      FirebaseFirestore.instance
          .collection("users")
          .add({"username": username, "email": email, "password": password,"gender":gender,"date":date});
      print("user saved success");
      emit(SaveUserSuccessState());
    } on Exception catch (e) {
      emit(SaveUserErrorState(e));
      print("couldnt save user $e");
    }
  }
  showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  String error = "";
  Uint8List? image;

  registerUser(emailAddress, password) async {
    emit(RegisterUserLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(RegisterUserSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
        emit(RegisterUserError());
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
        emit(RegisterUserError());
      }
    } catch (e) {
      emit(RegisterUserError());
    }
  }

  saveUser(email, password, username, gender, date, image) async {
    emit(SaveUserLoadingState());
    try {
      FirebaseFirestore.instance.collection("users").add({
        "username": username,
        "email": email,
        "password": password,
        "gender": gender,
        "date": date,
        "image": image
      });
      print("user saved success");
      emit(SaveUserSuccessState());
    } on Exception catch (e) {
      emit(SaveUserErrorState());
      print("couldnt save user $e");
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    } else {}
  }

  selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    image = img;
  }

  Future<String> uploadImage(Uint8List file, email) async {
    String imgName = email;
    Reference ref =
        FirebaseStorage.instance.ref('profile_image').child(imgName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

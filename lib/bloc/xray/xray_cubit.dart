import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'xray_state.dart';

class XrayCubit extends Cubit<XrayState> {
  XrayCubit() : super(XrayInitial());

  static XrayCubit get(context) => BlocProvider.of(context);
  XFile? file;
  Uint8List? image;
  pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file!.readAsBytes();
    } else {
      print("No Image Selected");
    }
  }
  Future chooseUserXray()async{
    Uint8List? img = await pickImage();
    if (img != null) {
      image = img;

    }
  }
}

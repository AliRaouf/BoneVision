import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

part 'xray_state.dart';

class XrayCubit extends Cubit<XrayState> {
  XrayCubit() : super(XrayInitial());

  static XrayCubit get(context) => BlocProvider.of(context);
  XFile? file;
  Uint8List? image;
  Uint8List? resizedImage;
  pickImage() async {
    final ImagePicker imagePicker = ImagePicker();
    file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return await file!.readAsBytes();
    } else {
      print("No Image Selected");
    }
  }
  Future chooseUserXray()async {
    Uint8List? img = await pickImage();
    if (img != null) {
      print("Original image size: ${img.lengthInBytes} bytes");
      image = img;
    }
  }
  void drawSquare(int x, int y, int width, int height) {
    if (resizedImage != null) {
      img.Image image = img.decodeImage(resizedImage!)!;
      img.drawRect(
        image,
        x1:x,
        y1:y,
        x2:x + width,
        y2:y + height,
       color:img.ColorRgb8(255, 0, 0), // Red color
      );
      resizedImage = Uint8List.fromList(img.encodeJpg(image));
    }
  }
}

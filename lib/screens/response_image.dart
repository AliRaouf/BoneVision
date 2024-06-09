             import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/xray/xray_cubit.dart';

class ResponseImage extends StatefulWidget {
  const ResponseImage({super.key});

  @override
  State<ResponseImage> createState() => _ResponseImageState();
}

class _ResponseImageState extends State<ResponseImage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // XrayCubit.get(context).drawSquare((358 * 0.8).toInt(), (93.5 * 0.8).toInt(), 154, 51); // Scaled coordinates with original dimensions
    XrayCubit.get(context).drawSquare((408.0 * 0.8).toInt(), (142.5 * 0.8).toInt(), 100, 100); // Scaled coordinates with original dimensions
    var cubit = XrayCubit.get(context);
    return BlocBuilder<XrayCubit, XrayState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(

                children: [
                  SizedBox(width: 1.sw,height:200.h,
                      child: Image(image: MemoryImage(cubit.resizedImage!))),
                ],
              )
          ),
        );
      },
    );
  }
}


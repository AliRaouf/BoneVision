import 'package:bonevision/bloc/doctor/doctor_cubit.dart';
import 'package:bonevision/bloc/feedback/feedback_cubit.dart';
import 'package:bonevision/bloc/help_center/helpcenter_cubit.dart';
import 'package:bonevision/bloc/login/login_cubit.dart';
import 'package:bonevision/bloc/register_cubit.dart';
import 'package:bonevision/bloc/user/user_cubit.dart';
import 'package:bonevision/bloc/xray/xray_cubit.dart';
import 'package:flutter/material.dart';
import 'package:bonevision/screens/start_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>RegisterCubit()),
      BlocProvider(create: (context)=>LoginCubit()),
      BlocProvider(create: (context)=>UserCubit()),
    BlocProvider(create: (context)=>HelpcenterCubit()),
      BlocProvider(create: (context)=>XrayCubit()),
      BlocProvider(create: (context)=>DoctorCubit()..receiveMessage()),
      BlocProvider(create: (context)=>FeedbackCubit()),
    ],
      child:
        MaterialApp(debugShowCheckedModeBanner: false,theme: ThemeData(scaffoldBackgroundColor: Colors.white,),
            home: StartScreen()),
    );
  }
}

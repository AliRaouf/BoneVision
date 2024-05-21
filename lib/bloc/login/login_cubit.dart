import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  String? error;
  bool? isExist;
  signInWithEmail(email,password)async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error='No user found for that email.';
        emit(LoginErrorState(error));
      } else if (e.code == 'wrong-password') {
        error='Wrong password provided for that user.';
        emit(LoginErrorState(error));
      }else{
        error=e.message!;
        emit(LoginErrorState(error));
      }
    }
  }
  Future<User?> googleSignin() async {
    try {
      final googleSignIn = GoogleSignIn(scopes: ['email']);

      // Sign out the user to ensure they can choose an account each time
      await googleSignIn.signOut();

      final googleAccount = await googleSignIn.signIn();

      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      } else {
        return null;
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }
  Future<bool> doesEmailExist(String email) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot = await users.where('email', isEqualTo: email).get();
    return querySnapshot.docs.isNotEmpty;

  }
  Future resetUserPassword(String email)async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => print("success"));
  }
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }
}

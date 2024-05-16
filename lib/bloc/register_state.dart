part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorState extends RegisterState {
  final error;
  RegisterErrorState(this.error);
}
class SaveUserLoadingState extends RegisterState {}
class SaveUserSuccessState extends RegisterState {}
class SaveUserErrorState extends RegisterState {
  final error;
  SaveUserErrorState(this.error);
}
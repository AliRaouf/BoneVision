part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class GetUserDataState extends UserState {}
class ReceiveUserNameSuccessState extends UserState {}
class ReceiveUserNameLoadingState extends UserState {}
class ReceiveUserNameErrorState extends UserState {}
class ChangeUserPasswordSuccessState extends UserState {}
class ChangeUserPasswordLoadingState extends UserState {}
class ChangeUserPasswordErrorState extends UserState {}
class UpdateUserImageSuccess extends UserState {}
class UpdateUserImageFailure extends UserState {}
class UpdateUserDataSuccess extends UserState {}
class UpdateUserDataFailure extends UserState {}
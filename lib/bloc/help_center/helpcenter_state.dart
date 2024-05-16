part of 'helpcenter_cubit.dart';

@immutable
abstract class HelpcenterState {}

class HelpcenterInitial extends HelpcenterState {}
class MessageSendSuccessState extends HelpcenterState {}
class MessageSendErrorState extends HelpcenterState {}
class MessageSendLoadingState extends HelpcenterState {}
class MessageReceiveMessageState extends HelpcenterState {}
class MessageGetUserDataState extends HelpcenterState {}
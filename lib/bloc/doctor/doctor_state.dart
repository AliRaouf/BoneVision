part of 'doctor_cubit.dart';

@immutable
sealed class DoctorState {}

final class DoctorInitial extends DoctorState {}
final class MessageReceiveMessageState extends DoctorState{}
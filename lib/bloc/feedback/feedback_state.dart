part of 'feedback_cubit.dart';

@immutable
sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}
class SaveFeedBackLoading extends FeedbackState {}
class SaveFeedBackSuccess extends FeedbackState {}
class SaveFeedBackError extends FeedbackState {}

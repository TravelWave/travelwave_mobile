part of 'feedback_bloc_bloc.dart';

sealed class FeedbackBlocState extends Equatable {
  const FeedbackBlocState();

  @override
  List<Object> get props => [];
}

final class FeedbackBlocInitial extends FeedbackBlocState {}

class FeedbackSubmitting extends FeedbackBlocState {}

class FeedbackSubmitted extends FeedbackBlocState {}

class FeedbackError extends FeedbackBlocState {
  final String error;

  const FeedbackError(this.error);
}

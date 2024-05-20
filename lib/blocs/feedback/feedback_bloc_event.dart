part of 'feedback_bloc_bloc.dart';

sealed class FeedbackBlocEvent extends Equatable {
  const FeedbackBlocEvent();

  @override
  List<Object> get props => [];
}

class FeedbackSubmit extends FeedbackBlocEvent {
  final FeedBackMsg feedback;

  const FeedbackSubmit({required this.feedback});

  @override
  List<Object> get props => [feedback];
}

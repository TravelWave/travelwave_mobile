import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travelwave_mobile/data/local_data.dart';
import 'package:travelwave_mobile/models/feedback_model.dart';
import 'package:travelwave_mobile/repositories/feedback_repositary.dart';

part 'feedback_bloc_event.dart';
part 'feedback_bloc_state.dart';

class FeedbackBlocBloc extends Bloc<FeedbackBlocEvent, FeedbackBlocState> {
  final LocalStorage localData;
  FeedbackBlocBloc({required this.localData}) : super(FeedbackBlocInitial()) {
    on<FeedbackBlocEvent>((event, emit) async {
      if (event is FeedbackSubmit) {
        emit(FeedbackSubmitting());
        // final token = await localData.readFromStorage('Token');
        // Call the repository to submit the feedback
        try {
          await FeedbackRepository(token: "token")
              .submitFeedback(event.feedback);

          emit(FeedbackSubmitted());
        } catch (e) {
          emit(FeedbackError(e.toString()));
        }
      }
    });
  }
}

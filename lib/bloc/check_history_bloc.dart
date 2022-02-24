import 'package:app_puninar_test/model/model.dart';
import 'package:app_puninar_test/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'check_history_event.dart';
part 'check_history_state.dart';

class CheckHistoryBloc extends Bloc<CheckHistoryEvent, CheckHistoryState> {
  final CheckHistoryRepository checkHistoryRepository;
  CheckHistoryBloc({required this.checkHistoryRepository})
      : super(CheckHistoryLoading()) {
    on<FindCheckHistory>(_findCheckHistory);
  }

  void _findCheckHistory(
      FindCheckHistory event, Emitter<CheckHistoryState> emit) async {
    try {
      emit(CheckHistoryLoading());
      var result =
          await checkHistoryRepository.findCheckHistory(event.datetime);
      emit(CheckHistoryLoaded(historyData: result));
    } catch (e) {
      emit(CheckHistoryFailed(
          errMessage: "Error Finding Check History : " + e.toString()));
      rethrow;
    }
  }
}

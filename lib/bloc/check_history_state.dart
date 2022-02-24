part of 'check_history_bloc.dart';

abstract class CheckHistoryState extends Equatable {
  const CheckHistoryState();

  @override
  List<Object> get props => [];
}

class CheckHistoryLoading extends CheckHistoryState {}

class CheckHistoryLoaded extends CheckHistoryState {
  final List<CheckHistoryModel> historyData;
  const CheckHistoryLoaded({
    required this.historyData,
  });

  @override
  List<Object> get props => [historyData];
}

class CheckHistoryFailed extends CheckHistoryState {
  final String errMessage;
  const CheckHistoryFailed({
    required this.errMessage,
  });

  @override
  List<Object> get props => [errMessage];
}

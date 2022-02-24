part of 'check_history_bloc.dart';

abstract class CheckHistoryEvent extends Equatable {
  const CheckHistoryEvent();

  @override
  List<Object> get props => [];
}

class FindCheckHistory extends CheckHistoryEvent {
  final DateTime datetime;
  const FindCheckHistory({required this.datetime});

  @override
  List<Object> get props => [datetime];
}

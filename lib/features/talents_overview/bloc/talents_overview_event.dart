part of 'talents_overview_bloc.dart';

abstract class TalentsOverviewEvent extends Equatable {
  const TalentsOverviewEvent();

  @override
  List<Object> get props => [];
}

class TalentsOverviewLoadRequested extends TalentsOverviewEvent {}

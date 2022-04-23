part of 'talents_overview_bloc.dart';

enum TalentsOverviewLoadStatus { initial, success, failure }

class TalentsOverviewState extends Equatable {
  const TalentsOverviewState({
    this.loadStatus = TalentsOverviewLoadStatus.initial,
    this.talents = const <Talent>[],
    this.hasReachedMax = false,
  });

  final TalentsOverviewLoadStatus loadStatus;
  final List<Talent> talents;
  final bool hasReachedMax;

  TalentsOverviewState copyWith({
    TalentsOverviewLoadStatus? loadStatus,
    List<Talent>? talents,
    bool? hasReachedMax,
  }) {
    return TalentsOverviewState(
      loadStatus: loadStatus ?? this.loadStatus,
      talents: talents ?? this.talents,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [loadStatus, talents, hasReachedMax];
}

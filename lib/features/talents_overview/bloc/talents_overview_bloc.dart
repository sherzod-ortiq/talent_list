import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:talent_repository/talent_repository.dart';

part 'talents_overview_event.dart';
part 'talents_overview_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TalentsOverviewBloc
    extends Bloc<TalentsOverviewEvent, TalentsOverviewState> {
  TalentsOverviewBloc({
    required TalentRepository talentRepository,
  })  : _talentRepository = talentRepository,
        super(const TalentsOverviewState()) {
    on<TalentsOverviewLoadRequested>(
      _onTalentsOverviewLoadRequested,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final TalentRepository _talentRepository;

  // @override
  // Stream<TalentsOverviewState> mapEventToState(
  //     TalentsOverviewEvent event) async* {
  //   if (event is TalentsOverviewLoadRequested) {
  //     yield* _mapTalentsOverviewLoadRequestedToState();
  //   }
  // }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onTalentsOverviewLoadRequested(
    TalentsOverviewLoadRequested event,
    Emitter<TalentsOverviewState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.loadStatus == TalentsOverviewLoadStatus.initial) {
        final talents = await _talentRepository.getTalents();
        return emit(state.copyWith(
          loadStatus: TalentsOverviewLoadStatus.success,
          talents: talents,
          hasReachedMax: false,
        ));
      }
      final talents =
          await _talentRepository.getTalents(startIndex: state.talents.length);
      if (talents.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      } else {
        return emit(state.copyWith(
          loadStatus: TalentsOverviewLoadStatus.success,
          talents: List.of(state.talents)..addAll(talents),
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        loadStatus: TalentsOverviewLoadStatus.failure,
      ));
    }
  }
}

  // Stream<TalentsOverviewState>
  //     _mapTalentsOverviewLoadRequestedToState() async* {
  //   if (state.hasReachedMax) return;
  //   try {
  //     if (state.loadStatus == TalentsOverviewLoadStatus.initial) {
  //       final talents = await _talentRepository.getTalents();
  //       yield state.copyWith(
  //         loadStatus: TalentsOverviewLoadStatus.success,
  //         talents: talents,
  //         hasReachedMax: false,
  //       );
  //       return;
  //     }
  //     final talents =
  //         await _talentRepository.getTalents(startIndex: state.talents.length);
  //     if (talents.isEmpty) {
  //       yield state.copyWith(hasReachedMax: true);
  //       return;
  //     } else {
  //       yield state.copyWith(
  //         loadStatus: TalentsOverviewLoadStatus.success,
  //         talents: List.of(state.talents)..addAll(talents),
  //         hasReachedMax: false,
  //       );
  //       return;
  //     }
  //   } catch (_) {
  //     yield state.copyWith(
  //       loadStatus: TalentsOverviewLoadStatus.failure,
  //     );
  //     return;
  //   }
  // }

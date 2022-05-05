import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:talent_list/event_transformer/event_transformer.dart';
import 'package:talent_repository/talent_repository.dart';

part 'talents_overview_event.dart';
part 'talents_overview_state.dart';

class TalentsOverviewBloc
    extends Bloc<TalentsOverviewEvent, TalentsOverviewState> {
  TalentsOverviewBloc({
    required TalentRepository talentRepository,
  })  : _talentRepository = talentRepository,
        super(const TalentsOverviewState()) {
    on<TalentsOverviewLoadRequested>(
      _onTalentsOverviewLoadRequested,
      transformer: CustomEventTransformer.throttleDroppable(),
    );
  }

  final TalentRepository _talentRepository;

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
        emit(state.copyWith(
          loadStatus: TalentsOverviewLoadStatus.loading,
        ));
        final talents = await _talentRepository.getTalents();
        return emit(state.copyWith(
          loadStatus: TalentsOverviewLoadStatus.success,
          talents: talents,
          hasReachedMax: false,
        ));
      }
      emit(state.copyWith(
        loadStatus: TalentsOverviewLoadStatus.loading,
      ));
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

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:talent_list/event_transformer/event_transformer.dart';
import 'package:talent_repository/talent_repository.dart';

part 'albums_overview_event.dart';
part 'albums_overview_state.dart';

class AlbumsOverviewBloc
    extends Bloc<AlbumsOverviewEvent, AlbumsOverviewState> {
  AlbumsOverviewBloc({
    required int talentId,
    required TalentRepository talentRepository,
  })  : _talentId = talentId,
        _talentRepository = talentRepository,
        super(const AlbumsOverviewState()) {
    on<AlbumsOverviewLoadRequested>(
      _onAlbumsOverviewLoadRequested,
      transformer: CustomEventTransformer.throttleDroppable(),
    );
  }

  final int _talentId;
  final TalentRepository _talentRepository;

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onAlbumsOverviewLoadRequested(
    AlbumsOverviewLoadRequested event,
    Emitter<AlbumsOverviewState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.loadStatus == AlbumsOverviewLoadStatus.initial) {
        emit(state.copyWith(
          loadStatus: AlbumsOverviewLoadStatus.loading,
        ));
        final albums =
            await _talentRepository.getTalentAlbums(talentId: _talentId);
        return emit(state.copyWith(
          loadStatus: AlbumsOverviewLoadStatus.success,
          albums: albums,
          hasReachedMax: false,
        ));
      }
      emit(state.copyWith(
        loadStatus: AlbumsOverviewLoadStatus.loading,
      ));
      final albums = await _talentRepository.getTalentAlbums(
          talentId: _talentId, startIndex: state.albums.length);
      if (albums.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      } else {
        return emit(state.copyWith(
          loadStatus: AlbumsOverviewLoadStatus.success,
          albums: List.of(state.albums)..addAll(albums),
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        loadStatus: AlbumsOverviewLoadStatus.failure,
      ));
    }
  }
}

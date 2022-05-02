import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:talent_repository/talent_repository.dart';

part 'talent_details_event.dart';
part 'talent_details_state.dart';

class TalentDetailsBloc extends Bloc<TalentDetailsEvent, TalentDetailsState> {
  TalentDetailsBloc({
    required int talentId,
    required TalentRepository talentRepository,
  })  : _talentRepository = talentRepository,
        _talentId = talentId,
        super(const TalentDetailsState()) {
    on<TalentDetailsPostsLoadRequested>(
      _onTalentDetailsPostsLoadRequested,
    );
    on<TalentDetailsAlbumsLoadRequested>(
      _onTalentDetailsAlbumsLoadRequested,
    );
  }

  final TalentRepository _talentRepository;
  final int _talentId;
  final int _previewLimit = 3;

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onTalentDetailsPostsLoadRequested(
    TalentDetailsPostsLoadRequested event,
    Emitter<TalentDetailsState> emit,
  ) async {
    try {
      if (state.postsLoadStatus == TalentDetailsLoadStatus.initial) {
        emit(state.copyWith(
          postsLoadStatus: TalentDetailsLoadStatus.loading,
        ));
        final posts = await _talentRepository.getTalentPosts(
            talentId: _talentId, limit: _previewLimit);
        return emit(state.copyWith(
          posts: posts,
          postsLoadStatus: TalentDetailsLoadStatus.success,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        postsLoadStatus: TalentDetailsLoadStatus.failure,
      ));
    }
  }

  Future<void> _onTalentDetailsAlbumsLoadRequested(
    TalentDetailsAlbumsLoadRequested event,
    Emitter<TalentDetailsState> emit,
  ) async {
    try {
      if (state.albumsLoadStatus == TalentDetailsLoadStatus.initial) {
        emit(state.copyWith(
          albumsLoadStatus: TalentDetailsLoadStatus.loading,
        ));
        final albums = await _talentRepository.getTalentAlbums(
            talentId: _talentId, limit: _previewLimit);
        return emit(state.copyWith(
          albums: albums,
          albumsLoadStatus: TalentDetailsLoadStatus.success,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        albumsLoadStatus: TalentDetailsLoadStatus.failure,
      ));
    }
  }
}

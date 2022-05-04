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
    on<TalentDetailsAlbumPhotosLoadRequested>(
      _onTalentDetailsAlbumPhotosLoadRequested,
    );
  }

  final TalentRepository _talentRepository;
  final int _talentId;
  final int _postsPreviewLimit = 3;
  final int _albumsPreviewLimit = 3;
  final int _albumPhotosPreviewLimit = 4;

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
            talentId: _talentId, limit: _postsPreviewLimit);
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
            talentId: _talentId, limit: _albumsPreviewLimit);
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

  Future<void> _onTalentDetailsAlbumPhotosLoadRequested(
    TalentDetailsAlbumPhotosLoadRequested event,
    Emitter<TalentDetailsState> emit,
  ) async {
    try {
      if (state.albumPhotosLoadStatus[event.albumId] == null ||
          state.albumPhotosLoadStatus[event.albumId] ==
              TalentDetailsLoadStatus.initial) {
        var _albumPhotosLoadStatus = {...state.albumPhotosLoadStatus};
        _albumPhotosLoadStatus[event.albumId] = TalentDetailsLoadStatus.loading;

        emit(state.copyWith(
          albumPhotosLoadStatus: _albumPhotosLoadStatus,
        ));

        final _albumPhotos = await _talentRepository.getAlbumPhotos(
            albumId: event.albumId, limit: _albumPhotosPreviewLimit);

        final _photos = {...state.photos};
        _photos[event.albumId] = _albumPhotos;

        _albumPhotosLoadStatus = state.albumPhotosLoadStatus;
        _albumPhotosLoadStatus[event.albumId] = TalentDetailsLoadStatus.success;

        return emit(state.copyWith(
          photos: _photos,
          albumPhotosLoadStatus: _albumPhotosLoadStatus,
        ));
      }
    } catch (_) {
      final _albumPhotosLoadStatus = state.albumPhotosLoadStatus;
      _albumPhotosLoadStatus[event.albumId] = TalentDetailsLoadStatus.failure;

      return emit(state.copyWith(
        albumPhotosLoadStatus: _albumPhotosLoadStatus,
      ));
    }
  }
}

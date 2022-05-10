import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:talent_repository/talent_repository.dart';

part 'album_details_event.dart';
part 'album_details_state.dart';

class AlbumDetailsBloc extends Bloc<AlbumDetailsEvent, AlbumDetailsState> {
  AlbumDetailsBloc({
    required int albumId,
    required TalentRepository talentRepository,
  })  : _talentRepository = talentRepository,
        _albumId = albumId,
        super(const AlbumDetailsState()) {
    on<AlbumDetailsPhotosLoadRequested>(
      _onAlbumDetailsPhotosLoadRequested,
    );
  }

  final int _albumId;
  final TalentRepository _talentRepository;

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onAlbumDetailsPhotosLoadRequested(
    AlbumDetailsPhotosLoadRequested event,
    Emitter<AlbumDetailsState> emit,
  ) async {
    if (state.photoHasReachedMax) return;
    try {
      if (state.photosLoadStatus == AlbumDetailsLoadStatus.initial) {
        emit(state.copyWith(
          photosLoadStatus: AlbumDetailsLoadStatus.loading,
        ));
        final photos =
            await _talentRepository.getAlbumPhotos(albumId: _albumId);
        return emit(state.copyWith(
          photosLoadStatus: AlbumDetailsLoadStatus.success,
          photos: photos,
          photoHasReachedMax: false,
        ));
      }
      emit(state.copyWith(
        photosLoadStatus: AlbumDetailsLoadStatus.loading,
      ));
      final photos = await _talentRepository.getAlbumPhotos(
          albumId: _albumId, startIndex: state.photos.length);
      if (photos.isEmpty) {
        return emit(state.copyWith(photoHasReachedMax: true));
      } else {
        return emit(state.copyWith(
          photosLoadStatus: AlbumDetailsLoadStatus.success,
          photos: List.of(state.photos)..addAll(photos),
          photoHasReachedMax: false,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        photosLoadStatus: AlbumDetailsLoadStatus.failure,
      ));
    }
  }
}

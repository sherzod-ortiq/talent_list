part of 'album_details_bloc.dart';

enum AlbumDetailsLoadStatus { initial, loading, success, failure }

class AlbumDetailsState extends Equatable {
  const AlbumDetailsState({
    this.photos = const <Photo>[],
    this.photosLoadStatus = AlbumDetailsLoadStatus.initial,
    this.photoHasReachedMax = false,
  });

  final List<Photo> photos;
  final AlbumDetailsLoadStatus photosLoadStatus;
  final bool photoHasReachedMax;

  AlbumDetailsState copyWith({
    final List<Photo>? photos,
    final AlbumDetailsLoadStatus? photosLoadStatus,
    final bool? photoHasReachedMax,
  }) {
    return AlbumDetailsState(
      photos: photos ?? this.photos,
      photosLoadStatus: photosLoadStatus ?? this.photosLoadStatus,
      photoHasReachedMax: photoHasReachedMax ?? this.photoHasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        photos,
        photosLoadStatus,
        photoHasReachedMax,
      ];
}

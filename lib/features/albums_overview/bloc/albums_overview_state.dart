part of 'albums_overview_bloc.dart';

enum AlbumsOverviewLoadStatus { initial, loading, success, failure }

class AlbumsOverviewState extends Equatable {
  const AlbumsOverviewState({
    this.loadStatus = AlbumsOverviewLoadStatus.initial,
    this.albums = const <Album>[],
    this.hasReachedMax = false,
  });

  final AlbumsOverviewLoadStatus loadStatus;
  final List<Album> albums;
  final bool hasReachedMax;

  AlbumsOverviewState copyWith({
    AlbumsOverviewLoadStatus? loadStatus,
    List<Album>? albums,
    bool? hasReachedMax,
  }) {
    return AlbumsOverviewState(
      loadStatus: loadStatus ?? this.loadStatus,
      albums: albums ?? this.albums,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [loadStatus, albums, hasReachedMax];
}

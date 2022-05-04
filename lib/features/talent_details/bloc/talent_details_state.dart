part of 'talent_details_bloc.dart';

enum TalentDetailsLoadStatus { initial, loading, success, failure }

class TalentDetailsState extends Equatable {
  const TalentDetailsState({
    this.posts = const <Post>[],
    this.albums = const <Album>[],
    this.photos = const <int, List<Photo>>{},
    this.postsLoadStatus = TalentDetailsLoadStatus.initial,
    this.albumsLoadStatus = TalentDetailsLoadStatus.initial,
    this.albumPhotosLoadStatus = const <int, TalentDetailsLoadStatus>{},
  });

  final List<Post> posts;
  final List<Album> albums;
  final Map<int, List<Photo>> photos;
  final TalentDetailsLoadStatus postsLoadStatus;
  final TalentDetailsLoadStatus albumsLoadStatus;
  final Map<int, TalentDetailsLoadStatus> albumPhotosLoadStatus;

  TalentDetailsState copyWith({
    final List<Post>? posts,
    final List<Album>? albums,
    final Map<int, List<Photo>>? photos,
    final TalentDetailsLoadStatus? postsLoadStatus,
    final TalentDetailsLoadStatus? albumsLoadStatus,
    final Map<int, TalentDetailsLoadStatus>? albumPhotosLoadStatus,
  }) {
    return TalentDetailsState(
      posts: posts ?? this.posts,
      albums: albums ?? this.albums,
      photos: photos ?? this.photos,
      postsLoadStatus: postsLoadStatus ?? this.postsLoadStatus,
      albumsLoadStatus: albumsLoadStatus ?? this.albumsLoadStatus,
      albumPhotosLoadStatus:
          albumPhotosLoadStatus ?? this.albumPhotosLoadStatus,
    );
  }

  @override
  List<Object> get props => [
        posts,
        albums,
        photos,
        postsLoadStatus,
        albumsLoadStatus,
        albumPhotosLoadStatus,
      ];
}

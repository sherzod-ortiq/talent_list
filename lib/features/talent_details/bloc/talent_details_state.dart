part of 'talent_details_bloc.dart';

enum TalentDetailsLoadStatus { initial, loading, success, failure }

class TalentDetailsState extends Equatable {
  const TalentDetailsState({
    this.posts = const <Post>[],
    this.albums = const <Album>[],
    this.postsLoadStatus = TalentDetailsLoadStatus.initial,
    this.albumsLoadStatus = TalentDetailsLoadStatus.initial,
  });

  final List<Post> posts;
  final List<Album> albums;
  final TalentDetailsLoadStatus postsLoadStatus;
  final TalentDetailsLoadStatus albumsLoadStatus;

  TalentDetailsState copyWith({
    final List<Post>? posts,
    final List<Album>? albums,
    final TalentDetailsLoadStatus? postsLoadStatus,
    final TalentDetailsLoadStatus? albumsLoadStatus,
  }) {
    return TalentDetailsState(
      posts: posts ?? this.posts,
      albums: albums ?? this.albums,
      postsLoadStatus: postsLoadStatus ?? this.postsLoadStatus,
      albumsLoadStatus: albumsLoadStatus ?? this.albumsLoadStatus,
    );
  }

  @override
  List<Object> get props => [
        posts,
        albums,
        postsLoadStatus,
        albumsLoadStatus,
      ];
}

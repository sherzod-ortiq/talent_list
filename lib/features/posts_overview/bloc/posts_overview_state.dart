part of 'posts_overview_bloc.dart';

enum PostsOverviewLoadStatus { initial, loading, success, failure }

class PostsOverviewState extends Equatable {
  const PostsOverviewState({
    this.loadStatus = PostsOverviewLoadStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  final PostsOverviewLoadStatus loadStatus;
  final List<Post> posts;
  final bool hasReachedMax;

  PostsOverviewState copyWith({
    PostsOverviewLoadStatus? loadStatus,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostsOverviewState(
      loadStatus: loadStatus ?? this.loadStatus,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [loadStatus, posts, hasReachedMax];
}

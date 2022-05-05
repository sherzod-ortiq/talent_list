part of 'post_details_bloc.dart';

enum PostDetailsLoadStatus { initial, loading, success, failure }

class PostDetailsState extends Equatable {
  const PostDetailsState({
    this.comments = const <Comment>[],
    this.commentsLoadStatus = PostDetailsLoadStatus.initial,
    this.commentCreateStatus = PostDetailsLoadStatus.initial,
    this.hasReachedMax = false,
  });

  final List<Comment> comments;
  final PostDetailsLoadStatus commentsLoadStatus;
  final PostDetailsLoadStatus commentCreateStatus;
  final bool hasReachedMax;

  PostDetailsState copyWith({
    final List<Comment>? comments,
    final PostDetailsLoadStatus? commentsLoadStatus,
    final PostDetailsLoadStatus? commentCreateStatus,
    bool? hasReachedMax,
  }) {
    return PostDetailsState(
      comments: comments ?? this.comments,
      commentsLoadStatus: commentsLoadStatus ?? this.commentsLoadStatus,
      commentCreateStatus: commentCreateStatus ?? this.commentCreateStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props =>
      [comments, commentsLoadStatus, commentCreateStatus, hasReachedMax];
}

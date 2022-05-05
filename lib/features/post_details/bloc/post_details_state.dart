part of 'post_details_bloc.dart';

enum PostDetailsLoadStatus { initial, loading, success, failure }

class PostDetailsState extends Equatable {
  const PostDetailsState({
    this.comments = const <Comment>[],
    this.commentsLoadStatus = PostDetailsLoadStatus.initial,
    this.commentCreateStatus = PostDetailsLoadStatus.initial,
  });

  final List<Comment> comments;
  final PostDetailsLoadStatus commentsLoadStatus;
  final PostDetailsLoadStatus commentCreateStatus;

  PostDetailsState copyWith({
    final List<Comment>? comments,
    final PostDetailsLoadStatus? commentsLoadStatus,
    final PostDetailsLoadStatus? commentCreateStatus,
  }) {
    return PostDetailsState(
      comments: comments ?? this.comments,
      commentsLoadStatus: commentsLoadStatus ?? this.commentsLoadStatus,
      commentCreateStatus: commentCreateStatus ?? this.commentCreateStatus,
    );
  }

  @override
  List<Object> get props => [
        comments,
        commentsLoadStatus,
        commentCreateStatus,
      ];
}

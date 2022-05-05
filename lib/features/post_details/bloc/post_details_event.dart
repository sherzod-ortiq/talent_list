part of 'post_details_bloc.dart';

abstract class PostDetailsEvent extends Equatable {
  const PostDetailsEvent();

  @override
  List<Object> get props => [];
}

class PostDetailsCommentsLoadRequested extends PostDetailsEvent {}

class PostDetailsCommentCreateRequested extends PostDetailsEvent {
  const PostDetailsCommentCreateRequested({
    required this.name,
    required this.email,
    required this.text,
  });

  final String name;
  final String email;
  final String text;

  @override
  List<Object> get props => [name, email, text];
}

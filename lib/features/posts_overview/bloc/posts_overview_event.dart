part of 'posts_overview_bloc.dart';

abstract class PostsOverviewEvent extends Equatable {
  const PostsOverviewEvent();

  @override
  List<Object> get props => [];
}

class PostsOverviewLoadRequested extends PostsOverviewEvent {}

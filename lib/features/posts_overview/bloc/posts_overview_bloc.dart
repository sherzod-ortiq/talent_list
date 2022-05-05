import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:talent_list/event_transformer/event_transformer.dart';
import 'package:talent_repository/talent_repository.dart';

part 'posts_overview_event.dart';
part 'posts_overview_state.dart';

class PostsOverviewBloc extends Bloc<PostsOverviewEvent, PostsOverviewState> {
  PostsOverviewBloc({
    required int talentId,
    required TalentRepository talentRepository,
  })  : _talentId = talentId,
        _talentRepository = talentRepository,
        super(const PostsOverviewState()) {
    on<PostsOverviewLoadRequested>(
      _onPostsOverviewLoadRequested,
      transformer: CustomEventTransformer.throttleDroppable(),
    );
  }

  final int _talentId;
  final TalentRepository _talentRepository;

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onPostsOverviewLoadRequested(
    PostsOverviewLoadRequested event,
    Emitter<PostsOverviewState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.loadStatus == PostsOverviewLoadStatus.initial) {
        emit(state.copyWith(
          loadStatus: PostsOverviewLoadStatus.loading,
        ));
        final posts =
            await _talentRepository.getTalentPosts(talentId: _talentId);
        return emit(state.copyWith(
          loadStatus: PostsOverviewLoadStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      emit(state.copyWith(
        loadStatus: PostsOverviewLoadStatus.loading,
      ));
      final posts = await _talentRepository.getTalentPosts(
          talentId: _talentId, startIndex: state.posts.length);
      if (posts.isEmpty) {
        return emit(state.copyWith(hasReachedMax: true));
      } else {
        return emit(state.copyWith(
          loadStatus: PostsOverviewLoadStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        loadStatus: PostsOverviewLoadStatus.failure,
      ));
    }
  }
}

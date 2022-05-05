import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:talent_repository/talent_repository.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  PostDetailsBloc({
    required int postId,
    required TalentRepository talentRepository,
  })  : _talentRepository = talentRepository,
        _postId = postId,
        super(const PostDetailsState()) {
    on<PostDetailsCommentsLoadRequested>(
      _onPostDetailsCommentsLoadRequested,
    );
    on<PostDetailsCommentCreateRequested>(
      _onPostDetailsCommentCreateRequested,
    );
  }

  final int _postId;
  final TalentRepository _talentRepository;

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> _onPostDetailsCommentsLoadRequested(
    PostDetailsCommentsLoadRequested event,
    Emitter<PostDetailsState> emit,
  ) async {
    try {
      if (state.commentsLoadStatus == PostDetailsLoadStatus.initial) {
        emit(state.copyWith(
          commentsLoadStatus: PostDetailsLoadStatus.loading,
        ));
        final comments =
            await _talentRepository.getPostComments(postId: _postId);
        return emit(state.copyWith(
          comments: comments,
          commentsLoadStatus: PostDetailsLoadStatus.success,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        commentsLoadStatus: PostDetailsLoadStatus.failure,
      ));
    }
  }

  Future<void> _onPostDetailsCommentCreateRequested(
    PostDetailsCommentCreateRequested event,
    Emitter<PostDetailsState> emit,
  ) async {
    try {
      if (state.commentCreateStatus == PostDetailsLoadStatus.initial) {
        emit(state.copyWith(
          commentCreateStatus: PostDetailsLoadStatus.loading,
        ));
        // ignore: unused_local_variable
        final comment = await _talentRepository.createPostComment(
          postId: _postId,
          email: event.email,
          name: event.name,
          body: event.text,
        );
        // print(comment); we got new comment
        return emit(state.copyWith(
          commentCreateStatus: PostDetailsLoadStatus.success,
        ));
      }
    } catch (_) {
      return emit(state.copyWith(
        commentCreateStatus: PostDetailsLoadStatus.failure,
      ));
    }
  }
}

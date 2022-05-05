import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_list/extensions/extensions.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/features/post_details/post_details.dart';
import 'package:talent_list/shared_widgets/shared_widgets.dart';

class PostDetailsPage extends StatelessWidget {
  const PostDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/post-details';

  @override
  Widget build(BuildContext context) {
    final _post = ModalRoute.of(context)!.settings.arguments as Post;

    return BlocProvider(
      create: (context) => PostDetailsBloc(
        postId: _post.id,
        talentRepository: context.read<TalentRepository>(),
      )..add(PostDetailsCommentsLoadRequested()),
      child: PostDetailsView(post: _post),
    );
  }
}

class PostDetailsView extends StatefulWidget {
  const PostDetailsView({Key? key, required Post post})
      : _post = post,
        super(key: key);

  final Post _post;

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostDetailsBloc>().add(PostDetailsCommentsLoadRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _startAddNewComment(BuildContext context, PostDetailsBloc bloc) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewComment(bloc),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post details'),
        actions: const [],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 40.0,
        ),
        onPressed: () {
          _startAddNewComment(context, context.read<PostDetailsBloc>());
        },
      ),
      body: LayoutBuilder(
        builder: (
          BuildContext context,
          BoxConstraints viewportConstraints,
        ) {
          return Container(
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                    child: Text(
                      widget._post.title.capitalize(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      widget._post.body.capitalize(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.only(left: 15, top: 5.0, bottom: 5.0),
                    margin: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      'Comments:',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  BlocBuilder<PostDetailsBloc, PostDetailsState>(
                    builder: (context, state) {
                      if (state.comments.isEmpty) {
                        if (state.commentsLoadStatus ==
                            PostDetailsLoadStatus.loading) {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (state.commentsLoadStatus !=
                            PostDetailsLoadStatus.success) {
                          return const SizedBox();
                        } else {
                          return const Expanded(
                            child: Center(
                              child: Text(
                                "No comments yet",
                              ),
                            ),
                          );
                        }
                      }

                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 5),
                          itemBuilder: (BuildContext context, index) {
                            return index >= state.comments.length
                                ? const BottomLoader()
                                : CommentCard(comment: state.comments[index]);
                          },
                          itemCount: state.hasReachedMax
                              ? state.comments.length
                              : state.comments.length + 1,
                          controller: _scrollController,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

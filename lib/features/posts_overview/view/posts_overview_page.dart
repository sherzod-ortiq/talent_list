import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/posts_overview/posts_overview.dart';
import 'package:talent_list/shared_widgets/bottom_loader.dart';
import 'package:talent_repository/talent_repository.dart';

class PostsOverviewPage extends StatelessWidget {
  const PostsOverviewPage({Key? key}) : super(key: key);

  static const routeName = '/posts-overview';

  @override
  Widget build(BuildContext context) {
    final _talentId = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) => PostsOverviewBloc(
        talentId: _talentId,
        talentRepository: context.read<TalentRepository>(),
      )..add(PostsOverviewLoadRequested()),
      child: const PostsOverviewView(),
    );
  }
}

class PostsOverviewView extends StatefulWidget {
  const PostsOverviewView({Key? key}) : super(key: key);

  @override
  State<PostsOverviewView> createState() => _PostsOverviewViewState();
}

class _PostsOverviewViewState extends State<PostsOverviewView> {
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
      context.read<PostsOverviewBloc>().add(PostsOverviewLoadRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post list'),
        actions: const [],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PostsOverviewBloc, PostsOverviewState>(
            listenWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus,
            listener: (context, state) {
              if (state.loadStatus == PostsOverviewLoadStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Failed to load'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<PostsOverviewBloc, PostsOverviewState>(
          builder: (context, state) {
            if (state.posts.isEmpty) {
              if (state.loadStatus == PostsOverviewLoadStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.loadStatus != PostsOverviewLoadStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text(
                    "No posts yet",
                  ),
                );
              }
            }

            // return CupertinoScrollbar(
            //   child:
            return ListView.builder(
              itemBuilder: (BuildContext context, index) {
                return index >= state.posts.length
                    ? const BottomLoader()
                    : PostListTile(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
            // );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/talent_details/talent_details.dart';

class PostsPreview extends StatelessWidget {
  const PostsPreview({Key? key}) : super(key: key);

  final double _height = 120.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TalentDetailsBloc, TalentDetailsState>(
      listenWhen: (previous, current) =>
          previous.postsLoadStatus != current.postsLoadStatus,
      listener: (context, state) {
        if (state.postsLoadStatus == TalentDetailsLoadStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Failed to load posts'),
              ),
            );
        }
      },
      child: BlocBuilder<TalentDetailsBloc, TalentDetailsState>(
        builder: (context, state) {
          if (state.posts.isEmpty) {
            if (state.postsLoadStatus == TalentDetailsLoadStatus.loading) {
              return SizedBox(
                height: _height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.postsLoadStatus !=
                TalentDetailsLoadStatus.success) {
              return const SizedBox();
            } else {
              return SizedBox(
                height: _height,
                child: const Center(
                  child: Text(
                    "No posts yet",
                  ),
                ),
              );
            }
          }

          return SizedBox(
            height: _height,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                ...state.posts.map(
                    (post) => PostCardMini(title: post.title, body: post.body)),
                const PostsSeeMore(),
              ],
            ),
          );
        },
      ),
    );
  }
}

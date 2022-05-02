import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/features/talent_details/talent_details.dart';

class TalentDetailsPage extends StatelessWidget {
  const TalentDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/talent-details';

  @override
  Widget build(BuildContext context) {
    final _talent = ModalRoute.of(context)!.settings.arguments as Talent;

    return BlocProvider(
      create: (context) => TalentDetailsBloc(
        talentId: _talent.id,
        talentRepository: context.read<TalentRepository>(),
      )
        ..add(TalentDetailsPostsLoadRequested())
        ..add(TalentDetailsAlbumsLoadRequested()),
      child: TalentDetailsView(talent: _talent),
    );
  }
}

class TalentDetailsView extends StatelessWidget {
  const TalentDetailsView({Key? key, required Talent talent})
      : _talent = talent,
        super(key: key);

  final Talent _talent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_talent.username),
        actions: const [],
      ),
      body: BlocListener<TalentDetailsBloc, TalentDetailsState>(
        listenWhen: (previous, current) =>
            previous.postsLoadStatus != current.postsLoadStatus ||
            previous.albumsLoadStatus != current.albumsLoadStatus,
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
          if (state.albumsLoadStatus == TalentDetailsLoadStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Failed to load albums'),
                ),
              );
          }
        },
        child: BlocBuilder<TalentDetailsBloc, TalentDetailsState>(
          builder: (context, state) {
            if (state.posts.isEmpty) {
              if (state.postsLoadStatus == TalentDetailsLoadStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.postsLoadStatus !=
                  TalentDetailsLoadStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text(
                    "No posts yet",
                  ),
                );
              }
            }

            if (state.albums.isEmpty) {
              if (state.albumsLoadStatus == TalentDetailsLoadStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.albumsLoadStatus !=
                  TalentDetailsLoadStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text(
                    "No albums yet",
                  ),
                );
              }
            }

            return CupertinoScrollbar(
                child: ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) => Text(
                  "Post title: ${state.posts[index].title} Album title: ${state.albums[index].title}"),
              // TalentCard(talent: state.posts[index]),
            ));
          },
        ),
      ),
    );
  }
}

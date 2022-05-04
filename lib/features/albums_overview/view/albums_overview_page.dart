import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/albums_overview/albums_overview.dart';
import 'package:talent_repository/talent_repository.dart';

class AlbumsOverviewPage extends StatelessWidget {
  const AlbumsOverviewPage({Key? key}) : super(key: key);

  static const routeName = '/albums-overview';

  @override
  Widget build(BuildContext context) {
    final _talentId = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) => AlbumsOverviewBloc(
        talentId: _talentId,
        talentRepository: context.read<TalentRepository>(),
      )..add(AlbumsOverviewLoadRequested()),
      child: const AlbumsOverviewView(),
    );
  }
}

class AlbumsOverviewView extends StatelessWidget {
  const AlbumsOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album list'),
        actions: const [],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AlbumsOverviewBloc, AlbumsOverviewState>(
            listenWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus,
            listener: (context, state) {
              if (state.loadStatus == AlbumsOverviewLoadStatus.failure) {
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
        child: BlocBuilder<AlbumsOverviewBloc, AlbumsOverviewState>(
          builder: (context, state) {
            if (state.albums.isEmpty) {
              if (state.loadStatus == AlbumsOverviewLoadStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.loadStatus != AlbumsOverviewLoadStatus.success) {
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
              itemCount: state.albums.length,
              itemBuilder: (context, index) =>
                  AlbumListTile(album: state.albums[index]),
            ));
          },
        ),
      ),
    );
  }
}

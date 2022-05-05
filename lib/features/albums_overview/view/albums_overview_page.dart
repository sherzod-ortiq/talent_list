import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/albums_overview/albums_overview.dart';
import 'package:talent_repository/talent_repository.dart';
import 'package:talent_list/shared_widgets/shared_widgets.dart';

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

class AlbumsOverviewView extends StatefulWidget {
  const AlbumsOverviewView({Key? key}) : super(key: key);

  @override
  State<AlbumsOverviewView> createState() => _AlbumsOverviewViewState();
}

class _AlbumsOverviewViewState extends State<AlbumsOverviewView> {
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
      context.read<AlbumsOverviewBloc>().add(AlbumsOverviewLoadRequested());
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

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.albums.length
                    ? const BottomLoader()
                    : AlbumListTile(album: state.albums[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.albums.length
                  : state.albums.length + 1,
              controller: _scrollController,
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/talents_overview/talents_overview.dart';
import 'package:talent_repository/talent_repository.dart';
import 'package:talent_list/shared_widgets/shared_widgets.dart';

class TalentsOverviewPage extends StatelessWidget {
  const TalentsOverviewPage({Key? key}) : super(key: key);

  static const routeName = '/talents-overview';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TalentsOverviewBloc(
        talentRepository: context.read<TalentRepository>(),
      )..add(TalentsOverviewLoadRequested()),
      child: const TalentsOverviewView(),
    );
  }
}

class TalentsOverviewView extends StatefulWidget {
  const TalentsOverviewView({Key? key}) : super(key: key);

  @override
  State<TalentsOverviewView> createState() => _TalentsOverviewViewState();
}

class _TalentsOverviewViewState extends State<TalentsOverviewView> {
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
      context.read<TalentsOverviewBloc>().add(TalentsOverviewLoadRequested());
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
        title: const Text('Talent list'),
        actions: const [],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TalentsOverviewBloc, TalentsOverviewState>(
            listenWhen: (previous, current) =>
                previous.loadStatus != current.loadStatus,
            listener: (context, state) {
              if (state.loadStatus == TalentsOverviewLoadStatus.failure) {
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
        child: BlocBuilder<TalentsOverviewBloc, TalentsOverviewState>(
          builder: (context, state) {
            if (state.talents.isEmpty) {
              if (state.loadStatus == TalentsOverviewLoadStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.loadStatus !=
                  TalentsOverviewLoadStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text(
                    "No talents yet",
                  ),
                );
              }
            }

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.talents.length
                    ? const BottomLoader()
                    : TalentListTile(talent: state.talents[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.talents.length
                  : state.talents.length + 1,
              controller: _scrollController,
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/talents_overview/talents_overview.dart';
import 'package:talent_repository/talent_repository.dart';

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

class TalentsOverviewView extends StatelessWidget {
  const TalentsOverviewView({Key? key}) : super(key: key);

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

            return CupertinoScrollbar(
                child: ListView.builder(
              itemCount: state.talents.length,
              itemBuilder: (context, index) =>
                  TalentListTile(talent: state.talents[index]),
            ));
          },
        ),
      ),
    );
  }
}

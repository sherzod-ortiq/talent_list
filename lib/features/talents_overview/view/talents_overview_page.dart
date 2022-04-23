import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/talents_overview/talents_overview.dart';
import 'package:talent_repository/talent_repository.dart';

class TalentsOverviewPage extends StatelessWidget {
  const TalentsOverviewPage({Key? key}) : super(key: key);

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
    // final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        // title: Text(l10n.talentOverviewAppBarTitle),
        actions: const [
          // TalentsOverviewFilterButton(),
          // TalentsOverviewOptionsButton(),
        ],
      ),
      body:
          // MultiBlocListener(
          //   listeners: [
          // BlocListener<TalentsOverviewBloc, TalentsOverviewState>(
          //   listenWhen: (previous, current) =>
          //       previous.status != current.status,
          //   listener: (context, state) {
          //     if (state.status == TalentsOverviewStatus.failure) {
          //       ScaffoldMessenger.of(context)
          //         ..hideCurrentSnackBar()
          //         ..showSnackBar(
          //           SnackBar(
          //             content: Text(l10n.talentOverviewErrorSnackbarText),
          //           ),
          //         );
          //     }
          //   },
          // ),
          // BlocListener<TalentsOverviewBloc, TalentsOverviewState>(
          //   listenWhen: (previous, current) =>
          //       previous.lastDeletedTodo != current.lastDeletedTodo &&
          //       current.lastDeletedTodo != null,
          //   listener: (context, state) {
          //     final deletedTodo = state.lastDeletedTodo!;
          //     final messenger = ScaffoldMessenger.of(context);
          //     messenger
          //       ..hideCurrentSnackBar()
          //       ..showSnackBar(
          //         SnackBar(
          //           content: Text(
          //             l10n.talentOverviewTodoDeletedSnackbarText(
          //               deletedTodo.title,
          //             ),
          //           ),
          //           action: SnackBarAction(
          //             label: l10n.talentOverviewUndoDeletionButtonText,
          //             onPressed: () {
          //               messenger.hideCurrentSnackBar();
          //               context
          //                   .read<TalentsOverviewBloc>()
          //                   .add(const TalentsOverviewUndoDeletionRequested());
          //             },
          //           ),
          //         ),
          //       );
          //   },
          // ),
          // ],
          // child:
          BlocBuilder<TalentsOverviewBloc, TalentsOverviewState>(
        builder: (context, state) {
          // if (state.talent.isEmpty) {
          //   if (state.status == TalentsOverviewStatus.loading) {
          //     return const Center(child: CupertinoActivityIndicator());
          //   } else if (state.status != TalentsOverviewStatus.success) {
          //     return const SizedBox();
          //   } else {
          //     return Center(
          //       child: Text(
          //         l10n.talentOverviewEmptyText,
          //         style: Theme.of(context).textTheme.caption,
          //       ),
          //     );
          //   }
          // }

          // return CupertinoScrollbar(
          //   child: ListView(
          //     children: [
          //       for (final todo in state.filteredTalents)
          //         TodoListTile(
          //           todo: todo,
          //           onToggleCompleted: (isCompleted) {
          //             context.read<TalentsOverviewBloc>().add(
          //                   TalentsOverviewTodoCompletionToggled(
          //                     todo: todo,
          //                     isCompleted: isCompleted,
          //                   ),
          //                 );
          //           },
          //           onDismissed: (_) {
          //             context
          //                 .read<TalentsOverviewBloc>()
          //                 .add(TalentsOverviewTodoDeleted(todo));
          //           },
          //           onTap: () {
          //             Navigator.of(context).push(
          //               EditTodoPage.route(initialTodo: todo),
          //             );
          //           },
          //         ),
          //     ],
          //   ),
          // );

          return CupertinoScrollbar(
            child: ListView(
              children: [
                for (final talent in state.talents) Text(talent.name),
                // TodoListTile(
                //   todo: todo,
                //   onToggleCompleted: (isCompleted) {
                //     context.read<TalentsOverviewBloc>().add(
                //           TalentsOverviewTodoCompletionToggled(
                //             todo: todo,
                //             isCompleted: isCompleted,
                //           ),
                //         );
                //   },
                //   onDismissed: (_) {
                //     context
                //         .read<TalentsOverviewBloc>()
                //         .add(TalentsOverviewTodoDeleted(todo));
                //   },
                //   onTap: () {
                //     Navigator.of(context).push(
                //       EditTodoPage.route(initialTodo: todo),
                //     );
                //   },
                // ),
              ],
            ),
          );
        },
      ),
      // ),
    );
  }
}

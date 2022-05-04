import 'package:flutter/material.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/features/talent_details/talent_details.dart';

class TalentListTile extends StatelessWidget {
  TalentListTile({Key? key, required Talent talent})
      : _talent = talent,
        super(key: Key('${talent.id}'));

  final Talent _talent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TalentDetailsPage.routeName,
            arguments: _talent,
          );
        },
        child: ListTile(
          leading: const Icon(Icons.portrait),
          title: Text(_talent.username),
          subtitle: Text(_talent.name),
        ),
      ),
    );
  }
}

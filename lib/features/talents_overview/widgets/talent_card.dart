import 'package:flutter/material.dart';

import 'package:talent_repository/talent_repository.dart';

class TalentCard extends StatelessWidget {
  const TalentCard({Key? key, required Talent talent})
      : _talent = talent,
        super(key: const Key('&talent.id'));

  final Talent _talent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Card(
        margin: const EdgeInsets.all(0),
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(
            //   context,
            //   TalentCardDetailsScreen.routeName,
            //   arguments: bloc,
            // );
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _talent.username,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        _talent.username,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

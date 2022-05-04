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
      body: LayoutBuilder(
        builder: (
          BuildContext context,
          BoxConstraints viewportConstraints,
        ) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Container(
                margin: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _talent.name,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                      InfoTile(name: 'Email', value: _talent.email),
                      const Divider(),
                      InfoTile(name: 'Phone', value: _talent.phone),
                      const Divider(),
                      InfoTile(name: 'Website', value: _talent.website),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Company:',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SubInfoTile(
                              name: 'Name',
                              value: _talent.company['name'],
                            ),
                            SubInfoTile(
                              name: 'BS',
                              value: _talent.company['bs'],
                            ),
                            SubInfoTile(
                              name: 'Catch phrase',
                              value: _talent.company['catchPhrase'],
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address:',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SubInfoTile(
                              name: 'Street',
                              value: _talent.address['street'],
                            ),
                            SubInfoTile(
                              name: 'Suite',
                              value: _talent.address['suite'],
                            ),
                            SubInfoTile(
                              name: 'City',
                              value: _talent.address['city'],
                            ),
                            SubInfoTile(
                              name: 'Zipcode',
                              value: _talent.address['zipcode'],
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text('Posts:'),
                      ),
                      const PostsPreview(),
                      const Divider(),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text('Albums:'),
                      ),
                      const AlbumsPreview(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

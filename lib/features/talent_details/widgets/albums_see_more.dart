import 'package:flutter/material.dart';

import 'package:talent_list/features/albums_overview/albums_overview.dart';

class AlbumsSeeMore extends StatelessWidget {
  const AlbumsSeeMore({required int talentId, Key? key})
      : _talentId = talentId,
        super(key: key);

  final int _talentId;

  final double _width = 200;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AlbumsOverviewPage.routeName,
            arguments: _talentId,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Center(
            child: Center(
              child: Text(
                'See more ...',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

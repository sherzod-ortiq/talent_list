import 'package:flutter/material.dart';

import 'package:talent_list/features/posts_overview/posts_overview.dart';

class PostsSeeMore extends StatelessWidget {
  const PostsSeeMore({
    required int talentId,
    Key? key,
  })  : _talentId = talentId,
        super(key: key);

  final int _talentId;

  final double _width = 100;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PostsOverviewPage.routeName,
            arguments: _talentId,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(4),
          child: Center(
            child: Text(
              'See more ...',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      ),
    );
  }
}

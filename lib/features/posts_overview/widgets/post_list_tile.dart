import 'package:flutter/material.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/extensions/extensions.dart';

// import 'package:talent_list/features/talent_details/talent_details.dart';

class PostListTile extends StatelessWidget {
  PostListTile({Key? key, required Post post})
      : _post = post,
        super(key: Key('${post.id}'));

  final Post _post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      child: InkWell(
        // onTap: () {
        //   Navigator.pushNamed(
        //     context,
        //     PostDetailsPage.routeName,
        //     arguments: _post,
        //   );
        // },
        child: ListTile(
          title: Text(
            _post.title.capitalize(),
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            _post.body.shortFormat(30),
          ),
        ),
      ),
    );
  }
}

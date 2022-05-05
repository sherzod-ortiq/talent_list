import 'package:flutter/material.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/extensions/extensions.dart';

import 'package:talent_list/features/post_details/post_details.dart';

class PostCardMini extends StatelessWidget {
  const PostCardMini({
    Key? key,
    required Post post,
  })  : _post = post,
        super(key: key);

  final Post _post;

  final double _width = 300;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            PostDetailsPage.routeName,
            arguments: _post,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(4),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            title: Text(
              _post.title.shortFormat(35),
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(
              _post.body.shortFormat(40),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:talent_list/extensions/extensions.dart';

class PostCardMini extends StatelessWidget {
  const PostCardMini({
    Key? key,
    required String title,
    required String body,
  })  : _title = title,
        _body = body,
        super(key: key);

  final String _title;
  final String _body;

  final double _width = 300;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: InkWell(
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
              _title.capitalize(),
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text(
              _body.shortFormat(30),
            ),
          ),
        ),
      ),
    );
  }
}

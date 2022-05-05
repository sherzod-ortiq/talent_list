import 'package:flutter/material.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/extensions/extensions.dart';

// import 'package:talent_list/features/talent_details/talent_details.dart';

class AlbumListTile extends StatelessWidget {
  AlbumListTile({Key? key, required Album album})
      : _album = album,
        super(key: Key('${album.id}'));

  final Album _album;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: InkWell(
        // onTap: () {
        //   Navigator.pushNamed(
        //     context,
        //     AlbumDetailsPage.routeName,
        //     arguments: _album,
        //   );
        // },
        child: ListTile(
          leading: const Icon(Icons.photo),
          title: Text(
            _album.title.capitalize(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}

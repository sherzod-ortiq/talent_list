import 'package:flutter/material.dart';

import 'package:talent_list/extensions/extensions.dart';

import 'package:talent_repository/talent_repository.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key, required Photo photo})
      : _photo = photo,
        super(key: key);

  final Photo _photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Image.network(
              _photo.url,
              fit: BoxFit.cover,
              height: 600,
              width: 600,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  // ignore: unnecessary_string_interpolations
                  '${_photo.title.capitalize()}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

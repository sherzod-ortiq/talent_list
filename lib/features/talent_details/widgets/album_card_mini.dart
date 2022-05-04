import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/talent_details/talent_details.dart';

import 'package:talent_list/extensions/extensions.dart';

class AlbumCardMin extends StatelessWidget {
  const AlbumCardMin({
    Key? key,
    required int albumId,
    required String title,
  })  : _albumId = albumId,
        _title = title,
        super(key: key);

  final int _albumId;
  final String _title;
  final double _width = 200;

  @override
  Widget build(BuildContext context) {
    context
        .read<TalentDetailsBloc>()
        .add(TalentDetailsAlbumPhotosLoadRequested(albumId: _albumId));
    return BlocBuilder<TalentDetailsBloc, TalentDetailsState>(
      builder: (context, state) {
        return SizedBox(
          width: _width,
          child: InkWell(
            // onTap: () => selectMeal(context),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: Column(
                          children: [
                            if (state.photos[_albumId] == null) ...[
                              const SizedBox(
                                width: 180,
                                height: 180,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ] else if (state.photos[_albumId]!.isEmpty) ...[
                              const Image(
                                height: 180,
                                width: 180,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/album_placeholder.jpg',
                                ),
                              )
                            ] else if (state.photos[_albumId]!.length == 1) ...[
                              Image.network(
                                state.photos[_albumId]![0].thumbnailUrl,
                                height: 180,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            ] else if (state.photos[_albumId]!.length == 2) ...[
                              Image.network(
                                state.photos[_albumId]![0].thumbnailUrl,
                                height: 90,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                              Image.network(
                                state.photos[_albumId]![1].thumbnailUrl,
                                height: 90,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            ] else if (state.photos[_albumId]!.length == 3) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    state.photos[_albumId]![0].thumbnailUrl,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  Image.network(
                                    state.photos[_albumId]![1].thumbnailUrl,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    state.photos[_albumId]![2].thumbnailUrl,
                                    height: 90,
                                    width: 180,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ] else if (state.photos[_albumId]!.length == 4) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    state.photos[_albumId]![0].thumbnailUrl,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  Image.network(
                                    state.photos[_albumId]![1].thumbnailUrl,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.network(
                                    state.photos[_albumId]![2].thumbnailUrl,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                  Image.network(
                                    state.photos[_albumId]![3].thumbnailUrl,
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 0,
                        child: Container(
                          width: 150,
                          color: Theme.of(context).colorScheme.background,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          child: Text(
                            _title.capitalize(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

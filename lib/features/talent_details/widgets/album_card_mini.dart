import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/talent_details/talent_details.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/extensions/extensions.dart';

import 'package:talent_list/features/album_details/album_details.dart';

class AlbumCardMin extends StatelessWidget {
  const AlbumCardMin({
    Key? key,
    required Album album,
  })  : _album = album,
        super(key: key);

  final Album _album;
  final double _width = 200;

  @override
  Widget build(BuildContext context) {
    context
        .read<TalentDetailsBloc>()
        .add(TalentDetailsAlbumPhotosLoadRequested(albumId: _album.id));
    return BlocBuilder<TalentDetailsBloc, TalentDetailsState>(
      builder: (context, state) {
        return SizedBox(
          width: _width,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AlbumDetailsPage.routeName,
                arguments: _album,
              );
            },
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
                            if (state.photos[_album.id] == null) ...[
                              const SizedBox(
                                width: 180,
                                height: 180,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ] else if (state.photos[_album.id]!.isEmpty) ...[
                              Image(
                                height: 180,
                                width: 180,
                                fit: BoxFit.cover,
                                image: const AssetImage(
                                    'assets/images/album_placeholder.jpg'),
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              )
                            ] else if (state.photos[_album.id]!.length ==
                                1) ...[
                              MiniNetworkPhoto(
                                height: 180,
                                width: 180,
                                url: state.photos[_album.id]![0].thumbnailUrl,
                              ),
                            ] else if (state.photos[_album.id]!.length ==
                                2) ...[
                              MiniNetworkPhoto(
                                height: 90,
                                width: 180,
                                url: state.photos[_album.id]![0].thumbnailUrl,
                              ),
                              MiniNetworkPhoto(
                                height: 90,
                                width: 180,
                                url: state.photos[_album.id]![1].thumbnailUrl,
                              ),
                            ] else if (state.photos[_album.id]!.length ==
                                3) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MiniNetworkPhoto(
                                    height: 90,
                                    width: 90,
                                    url: state
                                        .photos[_album.id]![0].thumbnailUrl,
                                  ),
                                  MiniNetworkPhoto(
                                    height: 90,
                                    width: 90,
                                    url: state
                                        .photos[_album.id]![1].thumbnailUrl,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MiniNetworkPhoto(
                                    height: 90,
                                    width: 180,
                                    url: state
                                        .photos[_album.id]![2].thumbnailUrl,
                                  ),
                                ],
                              ),
                            ] else if (state.photos[_album.id]!.length ==
                                4) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MiniNetworkPhoto(
                                    height: 90,
                                    width: 90,
                                    url: state
                                        .photos[_album.id]![0].thumbnailUrl,
                                  ),
                                  MiniNetworkPhoto(
                                    height: 90,
                                    width: 90,
                                    url: state
                                        .photos[_album.id]![1].thumbnailUrl,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MiniNetworkPhoto(
                                    height: 90,
                                    width: 90,
                                    url: state
                                        .photos[_album.id]![2].thumbnailUrl,
                                  ),
                                  MiniNetworkPhoto(
                                    height: 90,
                                    width: 90,
                                    url: state
                                        .photos[_album.id]![3].thumbnailUrl,
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
                            _album.title.capitalize(),
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

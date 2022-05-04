import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:talent_list/features/talent_details/talent_details.dart';

class AlbumsPreview extends StatelessWidget {
  const AlbumsPreview({Key? key}) : super(key: key);

  final double _height = 200.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TalentDetailsBloc, TalentDetailsState>(
      listenWhen: (previous, current) =>
          previous.albumsLoadStatus != current.albumsLoadStatus,
      listener: (context, state) {
        if (state.albumsLoadStatus == TalentDetailsLoadStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Failed to load albums'),
              ),
            );
        }
      },
      child: BlocBuilder<TalentDetailsBloc, TalentDetailsState>(
        builder: (context, state) {
          if (state.albums.isEmpty) {
            if (state.albumsLoadStatus == TalentDetailsLoadStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.albumsLoadStatus !=
                TalentDetailsLoadStatus.success) {
              return const SizedBox();
            } else {
              return const Center(
                child: Text(
                  "No albums yet",
                ),
              );
            }
          }

          if (state.albums.isEmpty) {
            if (state.albumsLoadStatus == TalentDetailsLoadStatus.loading) {
              return SizedBox(
                height: _height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.albumsLoadStatus !=
                TalentDetailsLoadStatus.success) {
              return const SizedBox();
            } else {
              return SizedBox(
                height: _height,
                child: const Center(
                  child: Text(
                    "No albums yet",
                  ),
                ),
              );
            }
          }
          return SizedBox(
            height: _height,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                ...state.albums.map((album) =>
                    AlbumCardMin(albumId: album.id, title: album.title)),
                const AlbumsSeeMore(),
              ],
            ),
          );
        },
      ),
    );
  }
}

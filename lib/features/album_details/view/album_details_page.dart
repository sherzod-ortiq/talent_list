import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:talent_repository/talent_repository.dart';

import 'package:talent_list/features/album_details/album_details.dart';

class AlbumDetailsPage extends StatelessWidget {
  const AlbumDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/album-details';

  @override
  Widget build(BuildContext context) {
    final _album = ModalRoute.of(context)!.settings.arguments as Album;

    return BlocProvider(
      create: (context) => AlbumDetailsBloc(
        albumId: _album.id,
        talentRepository: context.read<TalentRepository>(),
      )..add(AlbumDetailsPhotosLoadRequested()),
      child: const AlbumDetailsView(),
    );
  }
}

class AlbumDetailsView extends StatefulWidget {
  const AlbumDetailsView({Key? key}) : super(key: key);

  @override
  State<AlbumDetailsView> createState() => _AlbumDetailsViewState();
}

class _AlbumDetailsViewState extends State<AlbumDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album photos'),
        actions: const [],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AlbumDetailsBloc, AlbumDetailsState>(
            listenWhen: (previous, current) =>
                previous.photosLoadStatus != current.photosLoadStatus,
            listener: (context, state) {
              if (state.photosLoadStatus == AlbumDetailsLoadStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Failed to load'),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<AlbumDetailsBloc, AlbumDetailsState>(
          builder: (context, state) {
            if (state.photos.isEmpty) {
              if (state.photosLoadStatus == AlbumDetailsLoadStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.photosLoadStatus !=
                  AlbumDetailsLoadStatus.success) {
                return const SizedBox();
              } else {
                return const Center(
                  child: Text(
                    "No photos yet",
                  ),
                );
              }
            }

            return Center(
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  aspectRatio: 16 / 13,
                ),
                itemCount: state.photoHasReachedMax
                    ? state.photos.length
                    : state.photos.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  if (itemIndex + 1 >= state.photos.length) {
                    context
                        .read<AlbumDetailsBloc>()
                        .add(AlbumDetailsPhotosLoadRequested());
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ImageSlider(photo: state.photos[itemIndex]);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

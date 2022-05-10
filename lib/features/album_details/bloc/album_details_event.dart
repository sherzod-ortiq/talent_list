part of 'album_details_bloc.dart';

abstract class AlbumDetailsEvent extends Equatable {
  const AlbumDetailsEvent();

  @override
  List<Object> get props => [];
}

class AlbumDetailsPhotosLoadRequested extends AlbumDetailsEvent {}

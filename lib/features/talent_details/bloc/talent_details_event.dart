part of 'talent_details_bloc.dart';

abstract class TalentDetailsEvent extends Equatable {
  const TalentDetailsEvent();

  @override
  List<Object> get props => [];
}

class TalentDetailsPostsLoadRequested extends TalentDetailsEvent {}

class TalentDetailsAlbumsLoadRequested extends TalentDetailsEvent {}

class TalentDetailsAlbumPhotosLoadRequested extends TalentDetailsEvent {
  const TalentDetailsAlbumPhotosLoadRequested({required this.albumId});

  final int albumId;

  @override
  List<Object> get props => [albumId];
}

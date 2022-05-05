part of 'albums_overview_bloc.dart';

abstract class AlbumsOverviewEvent extends Equatable {
  const AlbumsOverviewEvent();

  @override
  List<Object> get props => [];
}

class AlbumsOverviewLoadRequested extends AlbumsOverviewEvent {}

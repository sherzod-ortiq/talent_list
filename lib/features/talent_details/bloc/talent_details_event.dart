part of 'talent_details_bloc.dart';

abstract class TalentDetailsEvent extends Equatable {
  const TalentDetailsEvent();

  @override
  List<Object> get props => [];
}

class TalentDetailsPostsLoadRequested extends TalentDetailsEvent {}

class TalentDetailsAlbumsLoadRequested extends TalentDetailsEvent {}

import 'package:talent_api/talent_api.dart';

/// {@template talent_api}
/// The interface and models for an API providing access to talents.
/// {@endtemplate}
abstract class TalentApi {
  /// {@macro TalentApi}
  const TalentApi();

  /// getTalents
  Future<List<Talent>> getTalents({
    required int startIndex,
    required int limit,
  });

  /// getTalentPosts
  Future<List<Post>> getTalentPosts({
    required int talentId,
    required int startIndex,
    required int limit,
  });

  /// getTalentAlbums
  Future<List<Album>> getTalentAlbums({
    required int talentId,
    required int startIndex,
    required int limit,
  });

  /// getAlbumPhotos
  Future<List<Photo>> getAlbumPhotos({
    required int albumId,
    required int startIndex,
    required int limit,
  });
}

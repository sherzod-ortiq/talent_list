import 'package:talent_api/talent_api.dart';

/// {@template talent_repository}
/// A repository that handles talent related requests.
/// {@endtemplate}
class TalentRepository {
  /// {@macro talent_repository}
  const TalentRepository({
    required TalentApi talentApi,
  }) : _talentApi = talentApi;

  final TalentApi _talentApi;

  /// getTalents
  Future<List<Talent>> getTalents({
    int startIndex = 0,
    int limit = 20,
  }) {
    return _talentApi.getTalents(
      startIndex: startIndex,
      limit: limit,
    );
  }

  /// getTalentPosts
  Future<List<Post>> getTalentPosts({
    required int talentId,
    int startIndex = 0,
    int limit = 20,
  }) {
    return _talentApi.getTalentPosts(
      talentId: talentId,
      startIndex: startIndex,
      limit: limit,
    );
  }

  /// getTalentAlbums
  Future<List<Album>> getTalentAlbums({
    required int talentId,
    int startIndex = 0,
    int limit = 20,
  }) {
    return _talentApi.getTalentAlbums(
      talentId: talentId,
      startIndex: startIndex,
      limit: limit,
    );
  }

  /// getAlbumPhotos
  Future<List<Photo>> getAlbumPhotos({
    required int albumId,
    int startIndex = 0,
    int limit = 20,
  }) {
    return _talentApi.getAlbumPhotos(
      albumId: albumId,
      startIndex: startIndex,
      limit: limit,
    );
  }
}

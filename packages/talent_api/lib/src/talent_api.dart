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

  /// getPostComments
  Future<List<Comment>> getPostComments({
    required int postId,
    required int startIndex,
    required int limit,
  });

  /// createPostComment
  Future<Comment> createPostComment({
    required int postId,
    required String name,
    required String email,
    required String body,
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

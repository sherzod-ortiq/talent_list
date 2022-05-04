import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:talent_api/talent_api.dart';

/// {@template remote_talent_api}
/// The Dart implementation of talentApi that uses remote storage
/// {@endtemplate}
class RemoteTalentApi extends TalentApi {
  /// {@macro remote_talent_api}
  const RemoteTalentApi();

  @override
  Future<List<Talent>> getTalents({
    required int startIndex,
    required int limit,
  }) async {
    final response = await http.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/users',
        <String, String>{'_start': '$startIndex', '_limit': '$limit'},
      ),
    );

    if (response.statusCode == 200) {
      final talents = List<Map>.from(json.decode(response.body) as List)
          .map((jsonMap) => Talent.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      return talents;
    } else {
      throw Exception('Error fetching talents');
    }
  }

  @override
  Future<List<Post>> getTalentPosts({
    required int talentId,
    required int startIndex,
    required int limit,
  }) async {
    final response = await _fetchTalentData(
      talentId: talentId,
      model: 'posts',
      startIndex: startIndex,
      limit: limit,
    );

    if (response.statusCode == 200) {
      final posts = List<Map>.from(json.decode(response.body) as List)
          .map((jsonMap) => Post.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      return posts;
    } else {
      throw Exception('Error fetching talent posts');
    }
  }

  @override
  Future<List<Album>> getTalentAlbums({
    required int talentId,
    required int startIndex,
    required int limit,
  }) async {
    final response = await _fetchTalentData(
      talentId: talentId,
      model: 'albums',
      startIndex: startIndex,
      limit: limit,
    );

    if (response.statusCode == 200) {
      final albums = List<Map>.from(json.decode(response.body) as List)
          .map((jsonMap) => Album.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      return albums;
    } else {
      throw Exception('Error fetching talent albums');
    }
  }

  @override
  Future<List<Photo>> getAlbumPhotos({
    required int albumId,
    required int startIndex,
    required int limit,
  }) async {
    final response = await http.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/photos',
        <String, String>{'_start': '$startIndex', '_limit': '$limit'},
      ),
    );

    if (response.statusCode == 200) {
      final photos = List<Map>.from(json.decode(response.body) as List)
          .map((jsonMap) => Photo.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      return photos;
    } else {
      throw Exception('Error fetching photos');
    }
  }

  Future<http.Response> _fetchTalentData({
    required int talentId,
    required String model,
    required int startIndex,
    required int limit,
  }) async {
    return http.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/$model',
        <String, String>{
          'userId': '$talentId',
          '_start': '$startIndex',
          '_limit': '$limit',
        },
      ),
    );
  }
}

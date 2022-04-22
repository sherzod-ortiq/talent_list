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
    int startIndex = 0,
    int talentLimit = 20,
  }) async {
    final response = await http.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/users',
        <String, String>{'_start': '$startIndex', '_limit': '$talentLimit'},
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
}

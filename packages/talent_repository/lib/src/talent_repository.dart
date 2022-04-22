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
  Future<List<Talent>> getTalents() => _talentApi.getTalents();
}

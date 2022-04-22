import 'package:talent_api/talent_api.dart';

/// {@template talent_api}
/// The interface and models for an API providing access to talents.
/// {@endtemplate}
abstract class TalentApi {
  /// {@macro TalentApi}
  const TalentApi();

  /// getTalents
  Future<List<Talent>> getTalents();
}

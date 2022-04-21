import 'package:talent_api/talent_api.dart';

/// TalentApi
abstract class TalentApi {
  /// TalentApi constructor
  const TalentApi();

  /// getTalents
  Stream<List<Talent>> getTalents();
}

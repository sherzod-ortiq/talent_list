// ignore_for_file: prefer_const_constructors
import 'package:talent_api/talent_api.dart';
import 'package:test/test.dart';

class TestTalentApi extends TalentApi {
  TestTalentApi() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('TalentApi', () {
    test('can be instantiated', () {
      expect(TestTalentApi(), isNotNull);
    });
  });
}

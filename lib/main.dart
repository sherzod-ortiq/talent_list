import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:remote_talent_api/remote_talent_api.dart';
import 'package:talent_list/features/talents_overview/view/talents_overview_page.dart';
import 'package:talent_repository/talent_repository.dart';

// import 'package:talent_list/features/talents_overview/talents_overview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const talentRepository = TalentRepository(talentApi: RemoteTalentApi());

  runApp(const App(talentRepository: talentRepository));
}

class App extends StatelessWidget {
  const App({Key? key, required this.talentRepository}) : super(key: key);

  final TalentRepository talentRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: talentRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talent list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TalentsOverviewPage(),
    );
  }
}

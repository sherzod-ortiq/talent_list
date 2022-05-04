import 'package:talent_list/features/talents_overview/talents_overview.dart';
import 'package:talent_list/features/posts_overview/posts_overview.dart';
import 'package:talent_list/features/talent_details/talent_details.dart';

class CustomRoutes {
  static final routes = {
    TalentsOverviewPage.routeName: (context) => const TalentsOverviewPage(),
    PostsOverviewPage.routeName: (context) => const PostsOverviewPage(),
    TalentDetailsPage.routeName: (context) => const TalentDetailsPage(),
  };
}

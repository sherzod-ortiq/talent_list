import 'package:talent_list/features/talents_overview/talents_overview.dart';
import 'package:talent_list/features/posts_overview/posts_overview.dart';
import 'package:talent_list/features/albums_overview/albums_overview.dart';
import 'package:talent_list/features/talent_details/talent_details.dart';
import 'package:talent_list/features/post_details/post_details.dart';
import 'package:talent_list/features/album_details/album_details.dart';

class CustomRoutes {
  static final routes = {
    TalentsOverviewPage.routeName: (context) => const TalentsOverviewPage(),
    PostsOverviewPage.routeName: (context) => const PostsOverviewPage(),
    AlbumsOverviewPage.routeName: (context) => const AlbumsOverviewPage(),
    TalentDetailsPage.routeName: (context) => const TalentDetailsPage(),
    PostDetailsPage.routeName: (context) => const PostDetailsPage(),
    AlbumDetailsPage.routeName: (context) => const AlbumDetailsPage(),
  };
}

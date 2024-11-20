import 'package:dicoding_submission/models/anime_model.dart';
import 'package:dicoding_submission/pages/bottom_navbar.dart';
import 'package:dicoding_submission/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../pages/detail_page.dart';
import '../pages/login_page.dart';
import '../pages/notification_page.dart';
import '../pages/profile_page.dart';
import '../pages/register_page.dart';
import '../pages/search_page.dart';
import '../pages/watchlist_page.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String bottomNav = '/bottom-nav';
  static const String profile = '/profile';
  static const String watchlist = '/watchlist';
  static const String search = '/search';
  static const String notification = '/notification';
  static const String detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case detail:
        final Anime anime = settings.arguments as Anime;
        return MaterialPageRoute(builder: (_) => DetailPage(anime: anime, isLiked: anime.isLiked ?? false,));
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case search:
        return MaterialPageRoute(builder: (_) => SearchPage());
      case watchlist:
        return MaterialPageRoute(builder: (_) => WatchlistPage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case bottomNav:
        return MaterialPageRoute(builder: (_) => BottomNavbar());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
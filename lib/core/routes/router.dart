import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_project/features/auth/view/auth_view.dart';
import 'package:gemini_project/features/explore/view/explore_view.dart';
import 'package:gemini_project/features/feed/view/feed_view.dart';
import 'package:gemini_project/features/player/view/player_view.dart';
import 'package:gemini_project/features/profile/view/profile_view.dart';
import 'package:gemini_project/features/shell/view/shell_view.dart';
import 'package:go_router/go_router.dart';
// import 'package:youtube_social_app/features/auth/view/auth_view.dart';
// import 'package:youtube_social_app/features/explore/view/explore_view.dart';
// import 'package:youtube_social_app/features/feed/view/feed_view.dart';
// import 'package:youtube_social_app/features/player/view/player_view.dart';
// import 'package:youtube_social_app/features/profile/view/profile_view.dart';
// import 'package:youtube_social_app/features/shell/view/shell_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/feed',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthView(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ShellView(child: child);
        },
        routes: [
          GoRoute(
            path: '/feed',
            builder: (context, state) => const FeedView(),
          ),
          GoRoute(
            path: '/explore',
            builder: (context, state) => const ExploreView(),
          ),
          // A placeholder for profile tab, ideally you would want to show the logged-in user's profile
          GoRoute(
            path: '/profile-tab',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text("My Profile")),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/profile/:channelId',
        builder: (context, state) {
          final channelId = state.pathParameters['channelId']!;
          return ProfileView(channelId: channelId);
        },
      ),
      GoRoute(
        path: '/player/:videoId',
        builder: (context, state) {
          final videoId = state.pathParameters['videoId']!;
          return PlayerView(videoId: videoId);
        },
      ),
    ],
  );
});
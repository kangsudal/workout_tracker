import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/landing_page.dart';
import 'package:workout_tracker/workout_home_page.dart';
import 'package:workout_tracker/workout_list_page.dart';

final GoRouter myRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: "/workout_home",
      builder: (context, state) => const WorkoutHomePage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'workout_list',
          builder: (context, state) {
            return WorkoutListPage();
          },
        ),
      ],
    ),
  ],
);

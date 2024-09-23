import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/landing_page.dart';
import 'package:workout_tracker/workout_guide_page.dart';
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
          routes: [
            GoRoute(
              path: "workout_guide/:workouts_index",
              builder: (context, state) {
                String? workoutsIndexString =
                    state.pathParameters['workouts_index'];
                //url에 붙어있는 parameter중에 workout_index인 값
                int workoutsIndex;
                if (workoutsIndexString != null) {
                  workoutsIndex = int.parse(workoutsIndexString);
                  print(workoutsIndex);
                  return WorkoutGuidePage(workoutsIndex: workoutsIndex);
                } else {
                  return Scaffold(
                    appBar: AppBar(),
                    body: Center(
                      child: Text('잘못된 접근방법입니다!'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/animation_practice_widget.dart';
import 'package:workout_tracker/frame_page.dart';
import 'package:workout_tracker/landing_page.dart';
import 'package:workout_tracker/login_page.dart';
import 'package:workout_tracker/settings_page.dart';
import 'package:workout_tracker/workout_guide_page.dart';
import 'package:workout_tracker/workout_home_page.dart';
import 'package:workout_tracker/workout_list_page.dart';

//Nested route에는 key가 반드시 필요합니다. Key는 고유의 navigator를 갖는 애들에게 모두 부여합니다.
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeTab');
final GlobalKey<NavigatorState> _settingsTabNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settingsTab');

final GoRouter myRouter = GoRouter(
  navigatorKey: _rootNavigatorKey, //중요!!!!
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => AnimationPracticeWidget(),//const LandingPage(),
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey, //상위 router를 명시
      builder: (context, state, navigationShell) {
        // navigationShell: sub page
        // builder의 retrun은 index에 따라 tab을 전환시키는 widget
        return FramePage(navigationShell: navigationShell);
      },
      branches: [
        //NestedRoute가 정의되는 영역입니다. 우리는 tab이 두 개 이기에 StatefulShellBranch() 도 두개가 필요
        StatefulShellBranch(
          navigatorKey: _homeTabNavigatorKey,
          routes: [
            GoRoute(
              path: "/workout_home",
              builder: (context, state) =>  WorkoutHomePage(),
              routes: <RouteBase>[
                GoRoute(
                  path: 'workout_list/:group_index',
                  builder: (context, state) {
                    String? groupIndexString =
                        state.pathParameters['group_index'];
                    final groupIndex = int.parse(groupIndexString!);
                    return WorkoutListPage(groupIndex: groupIndex);
                  },
                  routes: [
                    GoRoute(
                      path: "workout_guide/:workouts_index",
                      builder: (context, state) {
                        String? workoutsIndexString =
                            state.pathParameters['workouts_index'];
                        //url에 붙어있는 parameter중에 workout_index인 값

                        String? groupIndexString =
                            state.pathParameters['group_index'];
                        final groupIndex = int.parse(groupIndexString!);

                        int workoutsIndex;
                        if (workoutsIndexString != null) {
                          workoutsIndex = int.parse(workoutsIndexString);
                          print(workoutsIndex);
                          return WorkoutGuidePage(
                            workoutsIndex: workoutsIndex,
                            groupIndex: groupIndex,
                          );
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
        ),
        StatefulShellBranch(
          navigatorKey: _settingsTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) {
                return SettingsPage();
              },
              routes: [
                GoRoute(
                  path: 'login',
                  builder: (context, state) {
                    return LoginPage();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

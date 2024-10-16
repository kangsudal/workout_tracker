import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/dashboard_card.dart';
import 'package:workout_tracker/landing_page.dart';
import 'package:workout_tracker/workout.dart';
import 'package:workout_tracker/workout_guide_page.dart';
import 'package:workout_tracker/workout_manager.dart';

class WorkoutListPage extends StatelessWidget {
  final int groupIndex;

  WorkoutListPage({super.key, required this.groupIndex}) {
    WorkoutManager.currentWorkoutGroupIndex = groupIndex;
    WorkoutManager.increaseMonthlyWorkoutCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout List')), //code줄임 표시
      body: SingleChildScrollView(
        child: Column(
          children: [getHero(context), ...getWorkoutList(context)],
        ),
      ),
    );
  }

  List<GestureDetector> getWorkoutList(BuildContext context) {
    List<Workout> workouts = WorkoutManager.workoutGroups[groupIndex].workouts;
    List<GestureDetector> workoutListRow = [];
    for (Workout workout in workouts) {
      String name = workout.name;
      String image = workout.imageName;
      int minutes = workout.minutes;
      int i = workouts.indexOf(workout);
      workoutListRow.add(
        GestureDetector(
          onTap: () {
            context
                .go('/workout_home/workout_list/$groupIndex/workout_guide/$i');
          },
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/$image')),
                ),
              ),
              Expanded(
                child: Text('${i + 1}.$name', style: TextStyle(fontSize: 20)),
              ),
              Text('$minutes 분',
                  style: TextStyle(fontSize: 20, color: Colors.blue))
            ],
          ),
        ),
      );
    }
    return workoutListRow;
  }

  Widget getHero(BuildContext context) {
    if (groupIndex == 0) {
      return Hero(
        tag: 'group_0',
        child: SizedBox(
          height: 150,
          child: DashboardCard(
            icon: Icon(
              Icons.run_circle_outlined,
              size: 33,
              color: Colors.white,
            ),
            backgroundColor: Colors.orange,
            title: Text(
              '그룹1',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            info: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(
                          WorkoutManager.workoutGroups[groupIndex].groupDescription,
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Image.asset('assets/sample1.png')),
              ],
            ),
          ),
        ),
      );
    } else if (groupIndex == 1) {
      return Hero(
        tag: 'group_1',
        child: SizedBox(
          height: 150,
          child: DashboardCard(
            icon: Icon(
              Icons.rowing_outlined,
              size: 33,
              color: Colors.white,
            ),
            backgroundColor: Colors.teal,
            title: Text(
              '그룹2',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            info: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(
                          WorkoutManager.workoutGroups[groupIndex].groupDescription,
                          style: TextStyle(fontSize: 23, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Image.asset('assets/sample2.png')),
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

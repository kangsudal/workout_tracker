import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/workout.dart';
import 'package:workout_tracker/workout_manager.dart';

class WorkoutGuidePage extends StatefulWidget {
  int workoutsIndex;
  int groupIndex;

  WorkoutGuidePage({
    super.key,
    required this.workoutsIndex,
    required this.groupIndex,
  });

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  final player = AudioPlayer();
  late Workout currentWorkout;
  late int currentIndex;
  late List<Workout> workouts;

  @override
  void initState() {
    super.initState();
    workouts = WorkoutManager.workoutGroups[widget.groupIndex].workouts;
    currentIndex = widget.workoutsIndex;
    currentWorkout = workouts[currentIndex];
    player.onPlayerComplete.listen((event) {
      //complete상태가 되는것을 listen해준다.
      setState(() {});
    });
    WorkoutManager.increaseTodayWorkoutMinutes(currentWorkout.minutes);
    WorkoutManager.increaseTodayWorkoutCalories(currentWorkout.kcal);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkoutGuide'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currentWorkout.name,
            style: TextStyle(fontSize: 35),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await player.stop();
                  prevWorkout();
                },
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 70,
              ),
              Expanded(
                child: Image.asset('assets/${currentWorkout.imageName}'),
              ),
              IconButton(
                onPressed: () async {
                  await player.stop();
                  nextWorkout();
                },
                icon: Icon(Icons.arrow_forward_ios),
                iconSize: 70,
              )
            ],
          ),
          Text(
            '${currentWorkout.minutes}',
            style: TextStyle(fontSize: 35, color: Colors.blue),
          ),
          getIconButton(),
        ],
      ),
    );
  }

  IconButton getIconButton() {
    if (player.state == PlayerState.playing) {
      return IconButton(
        onPressed: () async {
          await player.stop();
          setState(() {});
        },
        icon: Icon(Icons.stop_circle),
        iconSize: 70,
        color: Colors.deepOrange,
      );
    } else {
      return IconButton(
        onPressed: () async {
          await player.play(AssetSource('squat.mp3'));
          setState(() {});
        },
        icon: Icon(Icons.play_circle_fill),
        iconSize: 70,
        color: Colors.deepOrange,
      );
    }
  }

  void prevWorkout() {
    if (currentIndex == 0) {
      currentIndex = workouts.length - 1;
    } else {
      currentIndex--;
    }
    setState(() {
      currentWorkout = workouts[currentIndex];
    });
  }

  void nextWorkout() {
    if (currentIndex == workouts.length - 1) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }
    setState(() {
      currentWorkout = workouts[currentIndex];
    });
  }
}

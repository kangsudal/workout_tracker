import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/workout.dart';

class WorkoutGuidePage extends StatefulWidget {
  int workoutsIndex;
  WorkoutGuidePage({super.key, required this.workoutsIndex});

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  List<Workout> workouts = [
    Workout(
      name: '스쿼트',
      minutes: 30,
      imageName: 'squat.jpeg',
      audioName: 'squat.mp3',
      kcal: 200,
    ),
    Workout(
      name: '사이드런지',
      minutes: 20,
      imageName: 'side_lunge.jpeg',
      audioName: 'side_lunge.mp3',
      kcal: 100,
    ),
    Workout(
      name: '푸쉬업',
      minutes: 15,
      imageName: 'pushup.jpeg',
      audioName: 'pushup.mp3',
      kcal: 100,
    ),
    Workout(
      name: '마운틴클림버',
      minutes: 15,
      imageName: 'mountain_climber.jpeg',
      audioName: 'mountain_climber.mp3',
      kcal: 50,
    ),
    Workout(
      name: '런지',
      minutes: 20,
      imageName: 'lunge.jpeg',
      audioName: 'lunge.mp3',
      kcal: 100,
    ),
    Workout(
      name: '덤벨컬',
      minutes: 40,
      imageName: 'dumbell_curl.jpeg',
      audioName: 'dumbell_curl.mp3',
      kcal: 200,
    ),
    Workout(
      name: '덩키킥',
      minutes: 30,
      imageName: 'donkey_kick.jpeg',
      audioName: 'donkey_kick.mp3',
      kcal: 50,
    ),
    Workout(
      name: '친업',
      minutes: 25,
      imageName: 'chinup.jpeg',
      audioName: 'chinup.mp3',
      kcal: 300,
    ),
    Workout(
      name: '벤치프레스',
      minutes: 10,
      imageName: 'benchpress.jpeg',
      audioName: 'benchpress.mp3',
      kcal: 250,
    ),
  ];
  final player = AudioPlayer();
  late Workout currentWorkout;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.workoutsIndex;
    currentWorkout = workouts[currentIndex];
    player.onPlayerComplete.listen((event) {
      //complete상태가 되는것을 listen해준다.
      setState(() {});
    });
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
                onPressed: () async{
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
                onPressed: () async{
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

  void prevWorkout(){

    if (currentIndex == 0) {
      currentIndex = workouts.length - 1;
    } else {
      currentIndex--;
    }
    setState(() {
      currentWorkout = workouts[currentIndex];
    });
  }

  void nextWorkout(){

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
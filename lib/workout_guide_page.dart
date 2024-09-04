import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class WorkoutGuidePage extends StatefulWidget {
  WorkoutGuidePage({super.key});

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  final player = AudioPlayer();

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
            '스쿼트',
            style: TextStyle(fontSize: 35),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 70,
              ),
              Expanded(
                child: Image.asset('assets/squat.jpeg'),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios),
                iconSize: 70,
              )
            ],
          ),
          Text(
            '30분',
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
}

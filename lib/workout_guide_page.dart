import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class WorkoutGuidePage extends StatelessWidget {
  WorkoutGuidePage({super.key});
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
          IconButton(
            onPressed: () {
              player.play(AssetSource('squat.mp3'));
            },
            icon: Icon(Icons.play_circle_fill),
            iconSize: 70,
            color: Colors.deepOrange,
          )
        ],
      ),
    );
  }
}

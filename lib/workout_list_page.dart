import 'package:flutter/material.dart';

class WorkoutListPage extends StatelessWidget {
  const WorkoutListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout List')), //code줄임 표시
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage('assets/squat.jpeg')),
                ),
              ),
              Expanded(child: Text('1.스쿼트', style: TextStyle(fontSize: 20))),
              Text('05:30', style: TextStyle(fontSize: 20, color: Colors.blue))
            ],
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/mountain_climber.jpeg')),
                ),
              ),
              Expanded(child: Text('2.마운틴클림버', style: TextStyle(fontSize: 20))),
              Text('05:30', style: TextStyle(fontSize: 20, color: Colors.blue))
            ],
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/benchpress.jpeg')),
                ),
              ),
              Expanded(
                  child: Text('3.benchpress', style: TextStyle(fontSize: 20))),
              Text('05:30', style: TextStyle(fontSize: 20, color: Colors.blue))
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker/workout_manager.dart';

import 'dashboard_card.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  late Future<int> monthlyCountFuture;

  @override
  void initState() {
    super.initState();
    monthlyCountFuture = WorkoutManager.getMonthlyWorkoutCount();
  }

  @override
  void didUpdateWidget(covariant WorkoutHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    monthlyCountFuture=WorkoutManager.getMonthlyWorkoutCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Just Do It',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text('간단하다. 흔들리면 그것은 지방이다.'),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/me.jpg')),
                    border: Border.all(
                      color: Colors.amber,
                      width: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                  child: DashboardCard(
                    icon: Icon(
                      Icons.fitness_center,
                      size: 33,
                      color: Colors.orange,
                    ),
                    title: Text(
                      'Monthly',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    info: FutureBuilder<int>(
                      builder: (context, snapshot) {
                        //snapshot: value값+상태를 같이 갖고있다.
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return CircularProgressIndicator();
                        }
                        else if(snapshot.hasError){
                          return Text('Error: ${snapshot.error}');
                        }
                        else if(snapshot.hasData){
                          //snapshot.requireData : null체크를 안해줘도 된다. = hasData와 함께쓰인다.
                          final monthlyWorkoutCount = snapshot.requireData ?? 0;
                          return Text(
                            '$monthlyWorkoutCount회',
                            style: TextStyle(
                                fontSize: 33, fontWeight: FontWeight.bold),
                          );
                        }else{
                          return Text(
                            '0회',
                            style: TextStyle(
                                fontSize: 33, fontWeight: FontWeight.bold),
                          );
                        }

                      },
                      future: monthlyCountFuture,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: DashboardCard(
                          icon: Icon(
                            Icons.update,
                            size: 33,
                            color: Colors.orange,
                          ),
                          title: Text(
                            '오늘운동시간',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          info: Text(
                            '10분',
                            style: TextStyle(
                                fontSize: 33, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DashboardCard(
                          icon: Icon(
                            Icons.fitness_center,
                            size: 33,
                            color: Colors.orange,
                          ),
                          title: Text(
                            '소모칼로리',
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          info: Text(
                            '100Kcal',
                            style: TextStyle(
                                fontSize: 33, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      child: DashboardCard(
                        customOnTap: () {
                          context.go('/workout_home/workout_list/0');
                        },
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
                            color: Colors.white,
                          ),
                        ),
                        info: Row(
                          children: [
                            Expanded(
                              child: Text(
                                WorkoutManager
                                    .workoutGroups[0].groupDescription,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Image.asset('assets/runner.png'),
                          ],
                        ),
                      ),
                      width: 250,
                    ),
                    SizedBox(
                      child: DashboardCard(
                        customOnTap: () {
                          context.go('/workout_home/workout_list/1');
                        },
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
                            color: Colors.white,
                          ),
                        ),
                        info: Text(
                          WorkoutManager.workoutGroups[1].groupDescription,
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      width: 250,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: DashboardCard(
              customOnTap: () {
                if (WorkoutManager.currentWorkoutGroupIndex == null) return;
                context.go(
                    '/workout_home/workout_list/${WorkoutManager.currentWorkoutGroupIndex}');
              },
              icon: Icon(
                Icons.list,
                size: 33,
                color: Colors.orange,
              ),
              backgroundColor: Colors.black87,
              title: Text(
                '운동 이어서 하기',
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              info: Text(
                '당신의 몸은 해 낼 수 있다. 당신의 마음만 설득하면 된다.',
                style: TextStyle(fontSize: 23, color: Colors.white),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

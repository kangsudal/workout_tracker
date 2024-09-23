import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_tracker/my_router.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
              image: AssetImage(
                'assets/runner.png',
              ),
              fit: BoxFit.cover,
              opacity: 0.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                color: Colors.yellowAccent,
                child: Text(
                  '남들이 그만둘 때, 난 계속한다',
                  style: GoogleFonts.nanumBrushScript(fontSize: 20),
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Text(
                      '환영합니다',
                      style: GoogleFonts.jua(fontSize: 30),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/workout_home');
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(fontSize: 35),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

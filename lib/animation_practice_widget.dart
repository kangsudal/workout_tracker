import 'package:flutter/material.dart';

class AnimationPracticeWidget extends StatefulWidget {
  const AnimationPracticeWidget({super.key});

  @override
  State<AnimationPracticeWidget> createState() => _AnimationPracticeWidgetState();
}

class _AnimationPracticeWidgetState extends State<AnimationPracticeWidget> with SingleTickerProviderStateMixin{
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    final Animation<double> _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    );

    _animation = Tween<double>(begin: 50.0, end: 200.0).animate(_curvedAnimation);
    _animation.addListener(() {
      setState(() {

      });
    });
    // _controller.addListener((){
    //   setState(() {});
    // });위와 같다. _aniatmion과 _controller를 연결시켜놨기때문
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: _animation.value, //begin:50 ~ end:200
        height: _animation.value,
        color: Colors.blue,
      ),
    );
  }
}

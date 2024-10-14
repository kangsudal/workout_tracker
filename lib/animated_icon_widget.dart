import 'package:flutter/material.dart';

class AnimatedIconWidget extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color color;

  const AnimatedIconWidget({
    super.key,
    required this.icon,
    required this.size,
    required this.color,
  });

  @override
  State<AnimatedIconWidget> createState() => _AnimatedIconWidgetState();
}

class _AnimatedIconWidgetState extends State<AnimatedIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutSine,
    );

    //다수의 range를 가진 animation을 만들어야한다.
    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 40.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 40.0, end: -20.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -20.0, end: 7.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 7.0, end: -3.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -3.5, end: 1.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 1),
    ]).animate(curvedAnimation);

    //해석: CurvedAnimation: 가속도, TweenSequence: 범위

    _animation.addListener(() {
      //animation 값이 바뀔때마다 화면 반영
      if (_animation.status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (_animation.status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      //setState를 할 필요없도록 AnimatedBuilder를 넣는다. AnimatedBuilder 내부만 다시그림
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 0.0174533, //double값을 radian 값으로 바꿔주는 수식
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.color,
          ),
        );
      },
      animation: _controller,
    );
  }
}

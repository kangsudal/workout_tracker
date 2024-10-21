import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedTextCarousel extends StatefulWidget {
  const AnimatedTextCarousel({super.key});

  @override
  State<AnimatedTextCarousel> createState() => _AnimatedTextCarouselState();
}

class _AnimatedTextCarouselState extends State<AnimatedTextCarousel> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  final List<List<String>> _texts = [
    ['Just Do It', '간단하다. 흔들리면 그것은 지방이다.'],
    ['꾸준히 하다 보면 변화가 온다.', '포기하지 말고 끝까지 해라.'],
    ['더 나은 내일을 위해', '오늘 최선을 다하자.'],
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), movePageCallBack);
    //movePageCallBack: 2초에 한번씩 실행될 콜백함수
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: PageView.builder(
          controller: _pageController,
          itemCount: _texts.length,
          itemBuilder: (context, index) {
            int loopedIndex = index % _texts.length;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    _texts[loopedIndex][0],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                FittedBox(child: Text(_texts[loopedIndex][1])),
              ],
            );
          }),
    );
  }

  void movePageCallBack(Timer timer) {
    _currentPage++;
    _pageController.animateToPage(
      _currentPage%3,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

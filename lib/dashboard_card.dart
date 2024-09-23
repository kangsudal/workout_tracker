import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  Icon icon;
  Text title;
  Widget info;
  Color? backgroundColor;
  VoidCallback? customOnTap;

  // VoidCallback? customOnTap = Function()? customOnTap; //return이 없고 parameter가 없는 method를 뜻한다.
  // GestureDetector에 타입을 맞추기위해. 그러면 함수명만 onTap에 넣어주면 된다.
  DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    this.backgroundColor,
    this.customOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: customOnTap,
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor ?? Colors.grey.shade300,
        ),
        child: Column(
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 10),
                title,
              ],
            ),
            Expanded(
              child: Center(child: info),
            ),
          ],
        ),
      ),
    );
  }
}

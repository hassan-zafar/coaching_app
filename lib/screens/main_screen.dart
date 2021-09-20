import 'package:flutter/material.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  static const routeName = '/MainScreen';
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(),],
    );
  }
}

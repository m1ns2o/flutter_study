import 'package:flutter/material.dart';
import 'package:inflearn/common/const/colors.dart';
import 'package:inflearn/common/layout/default_layout.dart';
import 'package:inflearn/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int index = 0;

  late TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(tabListner);
  }

  void tabListner() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(tabListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics:
            NeverScrollableScrollPhysics(), // 좌우로 제스쳐로 탭 넘기기 막기, 옵션제거시 좌능 스크롤로 탭이동 가능
        controller: controller,
        children: [
          RestaurantScreen(),
          Container(
            child: Text('food'),
          ),
          Container(
            child: Text('menu'),
          ),
          Container(
            child: Text('profile'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: 'food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.percent_outlined),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}

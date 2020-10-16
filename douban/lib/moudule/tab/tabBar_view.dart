import 'package:douban/util/constant.dart';
import 'package:flutter/material.dart';

class TabBarView extends StatefulWidget {
  @override
  _TabBarViewState createState() => _TabBarViewState();
}

class _TabBarViewState extends State<TabBarView> {

  int _curr = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _curr,
        children: TabNavigationItem.items.map((item) {
          return item.page;
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ConsColor.theme,
        currentIndex: _curr,
        onTap: (index) {
          setState(() {
            _curr = index;
          });
        },
        items: TabNavigationItem.items.map((item) {
          return BottomNavigationBarItem(
            title: item.title,
            icon: item.icon,
          );
        }).toList(),
      ),
    );
  }
}

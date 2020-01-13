import 'package:douban/moudule/home/drawer_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text('123')
        ),
        drawer: DrawerView()
    );
  }
}

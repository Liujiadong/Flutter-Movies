import 'package:douban/model/list_model.dart';
import 'package:douban/moudule/home/drawer_view.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CategoryViewModel(),
        child: Consumer<CategoryViewModel>(builder: (context, category, _) {
          return Scaffold(
            appBar: AppBar(title:
                Consumer<CategoryViewModel>(builder: (context, category, _) {
              return Text(LocalizationManger.i18n(context, category.title));
            })
            ),
            drawer: DrawerView(),
            body: Consumer<CategoryViewModel>(builder: (context, category, _) {

              return  Text('123');
            }),
          );
        }));
  }



}

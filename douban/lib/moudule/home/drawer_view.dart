import 'package:douban/model/category_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatelessWidget {
  final void Function(String title, String url) onTap;
  final VoidCallback onPressed;

  DrawerView({this.onTap, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        child: Column(
          children: <Widget>[
            UserDrawerHeader(onTap, onPressed),
            ...CategoryType.values.map((v) {
              final model = CategoryModel(v);

              return ListTile(
                  title: Text(LocalizationManger.i18n(context, model.title)),
                  leading: model.icon,
                  onTap: () {
                    Provider.of<CategoryViewModel>(context, listen: false)
                        .type = v;
                    RouterManager.pop(context);
                  });
            }).toList()
          ],
        ),
      ),
    );
  }
}

class UserDrawerHeader extends StatelessWidget {
  final void Function(String title, String url) onTap;
  final VoidCallback onPressed;

  UserDrawerHeader(this.onTap, this.onPressed);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      title: Column(
        children: <Widget>[
          Text(ConsString.name),
        ],
      ),
      automaticallyImplyLeading: false,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.settings), onPressed: onPressed),
        InkWell(
          child: Icon(Icons.home),
          onTap: () {
            onTap("${ConsString.name}'s Blog", ConsString.mail);
          },
        ),
        SizedBox(width: 15)
      ],
    );

  }
}

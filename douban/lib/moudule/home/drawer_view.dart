import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/category_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:douban/view_model/theme_view_model.dart';

class DrawerView extends StatelessWidget {

  void Function(String title, String url) onTap;
  VoidCallback onPressed;

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

  void Function(String title, String url) onTap;
  VoidCallback onPressed;

  UserDrawerHeader(this.onTap, this.onPressed);


  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeViewModel>(context);
    final themeData = theme.data(context);

    return UserAccountsDrawerHeader(
      accountName: Text(ConsString.name),
      accountEmail: InkWell(
        child: Text(ConsString.mail),
        onTap: () {
          onTap(ConsString.name, ConsString.mail);
        },
      ),
      currentAccountPicture:
          CachedNetworkImage(imageUrl: ConsString.avatar),
      otherAccountsPictures: <Widget>[
        IconButton(
            color: themeData.secondaryHeaderColor,
            icon: Icon(Icons.settings),
            onPressed: onPressed)
      ],
    );
  }
}

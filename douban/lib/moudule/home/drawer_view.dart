import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:douban/view_model/theme_view_model.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeViewModel>(context);

    return SizedBox(
      width: 200,
      child: Drawer(
        child: Column(
          children: <Widget>[
            UserDrawerHeader(),
            ListTile(
                title: Text(LocalizationManger.i18n(context, 'tab.hot')),
                leading: Icon(Icons.movie),
                onTap: () {
                  RouterManager.navigateTo(context, RouterType.detail);
                }),
            ListTile(
                title: Text(LocalizationManger.i18n(context, 'tab.new')),
                leading: Icon(Icons.fiber_new),
                onTap: () {}),
            ListTile(
                title: Text(LocalizationManger.i18n(context, 'tab.coming')),
                leading: Icon(Icons.sort),
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class UserDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeViewModel>(context);

    return UserAccountsDrawerHeader(
      accountName: Text('ZzzM'),
      accountEmail: Text('Github'),
      currentAccountPicture: CachedNetworkImage(imageUrl: 'http://dwz.date/ep8'),
      otherAccountsPictures: <Widget>[
        IconButton(
        color: theme.data.secondaryHeaderColor,
        icon: Icon(Icons.settings),
        onPressed: () {
          RouterManager.navigateTo(context, RouterType.settings);
        })
      ],
    );
  }
}

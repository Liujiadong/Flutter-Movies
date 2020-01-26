import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/category_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/movie_web_view.dart';
import 'package:douban/view_model/category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:douban/view_model/theme_view_model.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 200,
      child: Drawer(
        child: Column(
          children: <Widget>[
            UserDrawerHeader(),
            ...CategoryType.values.map((v){

              final model = CategoryModel(v);

              return ListTile(
                  title: Text(LocalizationManger.i18n(context,model.title)),
                  leading: model.icon,
                  onTap: () {
                    Provider.of<CategoryViewModel>(context, listen: false).type = v;
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
  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeViewModel>(context);
    final name = 'ZzzM';
    final mail = 'https://github.com/$name';

    return UserAccountsDrawerHeader(
      accountName: Text(name),
      accountEmail: InkWell(
        child: Text(mail),
        onTap: () {
          MovieWebView.open(context, mail, title: name);
        },
      ),
      currentAccountPicture: CachedNetworkImage(imageUrl: 'http://dwz.date/ep8'),
      otherAccountsPictures: <Widget>[
        IconButton(
        color: theme.data.secondaryHeaderColor,
        icon: Icon(Icons.settings),
        onPressed: () {
          RouterManager.pop(context);
          RouterManager.navigateTo(context, RouterType.settings);
        })
      ],
    );
  }
}

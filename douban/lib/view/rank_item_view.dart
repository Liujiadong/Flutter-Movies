import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/rank_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RankItemView extends StatelessWidget {
  RankItem item;

  RankItemView(this.item);

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Row(
        children: [
          _cover,
          _content(context)
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
    );
  }

  Widget get _cover {

    return Container(
        height: 120,
        width: 120,
        child: CachedNetworkImage(imageUrl: item.cover_url),
        decoration: BoxDecoration(
          border: Border.all(color: ConsColor.border,width: 0.5),
          boxShadow: [
            BoxShadow(
              color: ConsColor.border,
              blurRadius: 3,
            )
          ]
        )
    );
  }

  Widget _content(BuildContext context) {

    final theme = Provider.of<ThemeViewModel>(context, listen: false);
    final themeData = theme.data(context);

    return Container(
        width: screenWidth(context) - 140,
        height: 90,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: themeData.scaffoldBackgroundColor,
          border: Border.all(color: ConsColor.border, width: 0.5),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(5),
              topRight: Radius.circular(5)),

        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: item.items.map((movie) => _item(movie)).toList(),
      )
    );
  }

  Widget _item(RankMovie movie) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(movie.title,
              overflow: TextOverflow.ellipsis)
        ),
        SizedBox(width: 10),
        Text('${movie.rating.value}',
            style: TextStyle(color: Colors.orange)),
        SizedBox(width: 5)
      ],
    );

  }

}

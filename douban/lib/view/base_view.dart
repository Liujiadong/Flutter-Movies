import 'package:douban/model/movie_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ErrorView extends StatelessWidget {

  String message;
  VoidCallback onPressed;

  ErrorView(this.message, this.onPressed);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeViewModel>(context);
    final themeData = theme.data(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message),
          SizedBox(height: 20),
          RaisedButton(
            color: themeData.primaryColor,
            child: Text(LocalizationManger.i18n(context, 'refresh.reload'), style: TextStyle(color: themeData.secondaryHeaderColor)),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}

class RatingLabel extends StatelessWidget {

  String text;

  double normalSize;
  double noneSize;

  Color normalColor;
  Color noneColor;

  String placeholder;

  RatingLabel(this.text, {this.normalSize, this.noneSize, this.normalColor, this.noneColor, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Text(
      text != '0' ? text : placeholder ?? LocalizationManger.i18n(context, 'movie.none_rating'),
      style: TextStyle(
          fontSize: text != '0' ? normalSize : noneSize,
          fontWeight: FontWeight.bold,
          color: text != '0' ? normalColor : noneColor ?? normalColor),
    );
  }
}


class RatingStar extends StatelessWidget {

  num fullCount;
  num emptyCount;
  num halfCount;

  Icon fullIcon;
  Icon emptyIcon;
  Icon halfIcon;

  RatingStar(
      this.fullCount,
      this.fullIcon,
      this.emptyCount,
      this.emptyIcon,
      {this.halfCount, this.halfIcon});

  @override
  Widget build(BuildContext context) {
    final stars = List<Widget>();

    stars.addAll(List<Widget>.filled(fullCount, fullIcon));

    if (halfIcon != null) {
      stars.addAll(List<Widget>.filled(halfCount, halfIcon));
    }

    stars.addAll(List<Widget>.filled(emptyCount, emptyIcon));

    return Row(
      children: stars,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}


class RatingDesView extends StatelessWidget {

  MovieModel movie;

  RatingDesView(this.movie);


  Widget noneWidget = Text(
      '尚未上映',
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white)
  );

  Widget get ratingWidget {

    Map details = movie.rating.details;
    int total =
    (details.values.toList().reduce((curr, next) => curr + next)).toInt();

    List<String> keys = details.keys.toList();
    keys..sort();


    var sections = List<Widget>();

    keys.reversed.forEach((value) {

      int num = int.parse(value);
      double offset =  1 - details[value]/total;

      sections.add(Row(
        children: <Widget>[
          Row(
            children: List<Widget>.filled(num, Icon(Icons.star, size: 12, color: Colors.white30)),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Container(margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(2)),
              height: 5,
              width: 100,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(2)),
                margin: EdgeInsets.only(right: 100*offset),
              )
          )
        ],
      )
      );
    }

    );

    sections.add(
        Text("${movie.ratings_count}人评分",
            style: TextStyle(
                fontSize: 10,
                color: Colors.white))
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: sections,
    );
  }

  @override
  Widget build(BuildContext context) {
    return movie.rating.average == 0 ? noneWidget: ratingWidget;
  }
}

class RefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
        refreshingIcon: CupertinoActivityIndicator(),
        idleText: LocalizationManger.i18n(context, 'refresh.idleRefresh'),
        refreshingText: LocalizationManger.i18n(context, 'refresh.canRefresh'),
        releaseText: LocalizationManger.i18n(context, 'refresh.refreshing'),
        completeText: LocalizationManger.i18n(context, 'refresh.refreshComplete'),
        failedText: LocalizationManger.i18n(context, 'refresh.refreshFailed')
    );
  }
}

class RefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
        loadingIcon: CupertinoActivityIndicator(),
        idleText: LocalizationManger.i18n(context, 'refresh.idleLoading'),
        loadingText: LocalizationManger.i18n(context, 'refresh.loading'),
        canLoadingText: LocalizationManger.i18n(context, 'refresh.canLoading'),
        noDataText: LocalizationManger.i18n(context, 'refresh.noMore'),
        failedText: LocalizationManger.i18n(context, 'refresh.loadFailed')
    );
  }
}


import 'package:douban/model/movie_model.dart';
import 'package:douban/util/constant.dart';
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
          Text(message, style: TextStyle(fontSize: 15), textAlign: TextAlign.center),
          SizedBox(height: 15),
          RaisedButton(
            color: themeData.primaryColor,
            child: Text(LocalizationManger.i18n(context, 'refresh.reload'),
                style: TextStyle(color: Colors.white)),
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
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}


class RatingDesView extends StatelessWidget {

  Movie movie;

  RatingDesView(this.movie);

  Widget _textWidget(String text) {
    return Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12, color: Colors.white)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _textWidget('上映：${movie.released ? movie.pubdate : LocalizationManger.i18n(context, 'movie.unreleased')}'),
          _textWidget('类型：${movie.genres}'),
          _textWidget('片长：${movie.durations}'),
          _textWidget('地区：${movie.countries}'),
          _textWidget('语言：${movie.languages}'),
        ],
      )
    );

  }
}

class RefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
        failedIcon: Icon(Icons.error, color: ConsColor.theme),
        completeIcon: Icon(Icons.done, color: ConsColor.theme),
        idleIcon: Icon(Icons.arrow_downward, color: ConsColor.theme),
        releaseIcon: Icon(Icons.refresh, color: ConsColor.theme),
        refreshingIcon: SizedBox(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ConsColor.theme),
              strokeWidth: 3),
          height: 15.0,
          width: 15.0,
        ),
        idleText: '',
        refreshingText: '',
        releaseText: '',
        completeText: '',
        failedText: LocalizationManger.i18n(context, 'refresh.refreshFailed')

    );
  }
}

class RefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
        loadingIcon: SizedBox(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ConsColor.theme),
              strokeWidth: 3),
          height: 15.0,
          width: 15.0,
        ),
        canLoadingIcon: Icon(Icons.autorenew, color: ConsColor.theme),
        failedIcon: Icon(Icons.error, color: ConsColor.theme),
        idleIcon: Icon(Icons.arrow_upward, color:ConsColor.theme),

        idleText: '',
        loadingText: '',
        canLoadingText: '',
        noDataText: LocalizationManger.i18n(context, 'refresh.noMore'),
        failedText: LocalizationManger.i18n(context, 'refresh.loadFailed'),

    );
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 150),
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ConsColor.theme)),
        )
    );
  }
}

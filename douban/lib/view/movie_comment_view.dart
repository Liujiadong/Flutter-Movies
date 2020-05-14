import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieCommentView extends StatelessWidget {

  Map comment;
  bool showDivider;

  bool showMultiTheme;

  bool _isDark;

  MovieCommentView(
      this.comment,
      {this.showMultiTheme = false,
        this.showDivider = true,
      });

  Color get _textColor {
    final darkColor = Colors.white;
    if (showMultiTheme) {
      return _isDark ? darkColor: Colors.black;
    } else {
      return darkColor;
    }
  }

  Color get _noneColor {
    final darkColor = Colors.white30;
    if (showMultiTheme) {
      return _isDark ? darkColor: Colors.black12;;
    } else {
      return darkColor;
    }
  }

  Color get _countColor {
    final darkColor = Colors.white;
    if (showMultiTheme) {
      return _isDark ? darkColor: Colors.black45;;
    } else {
      return _textColor;
    }
  }




  @override
  Widget build(BuildContext context) {

    _isDark = Provider.of<ThemeViewModel>(context, listen: false).isDark(context);


    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _avatarWidget,
            SizedBox(height: 5),
            Text(content, style: TextStyle(color: _textColor, fontSize: 13)),
            showDivider ?  Divider(color: Colors.white70) : Container()
          ],
        ));
  }

  get content {
    return comment['summary'] != null ? comment['summary']: comment['content'];
  }

  get _avatarWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage:
                CachedNetworkImageProvider(comment['author']['avatar']),
              ),
              SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(comment['author']['name'],
                      style: TextStyle(color: _textColor, fontWeight: FontWeight.bold)),
                  _ratingWidget,
                ],
              )
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Icon(Icons.thumb_up, size: 15, color: _countColor),
            SizedBox(width: 5),
            _countWidget,
          ],
        ),
      ],
    );
  }

  Widget get _ratingWidget {
    final stars = List<Widget>();
    num value = comment['rating']['value'];
    String created_at = comment['created_at'];
    stars.addAll(List<Widget>.filled(value.toInt(), Icon(Icons.star, size: 15, color: Colors.amberAccent)));
    stars.addAll(List<Widget>.filled(5-value.toInt(), Icon(Icons.star, size: 15, color: _noneColor)));
    stars.add(SizedBox(width: 5));
    stars.add(Text(created_at.substring(0,10), style: TextStyle(color: _textColor, fontSize: 12)));
    return Row(
      children: stars,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget get _countWidget {
    var num = comment['useful_count'];
    var text = num.toString();
    if ( num >= 10000) {
      num /= 10000;
      text = num.toStringAsFixed(1) + '万';
    }
    return Text(text,
        style: TextStyle(color: _countColor));
  }

}

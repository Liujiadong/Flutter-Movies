import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/model/comment_model.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieCommentView extends StatelessWidget {

  CommentListItem item;

  bool _isDark;

  MovieCommentView(this.item);


  Color get _noneColor {
    final darkColor = Colors.white30;
    return _isDark ? darkColor: Colors.black12;
  }

  Color get _countColor {
    final darkColor = Colors.white;
    return _isDark ? darkColor: Colors.black45;
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
            Text(item.abstract, style: TextStyle(fontSize: 13)),
            Container()
          ],
        ));
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
                CachedNetworkImageProvider(item.user.avatar),
              ),
              SizedBox(width: 5),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item.user.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
    num value = item.rating.value;
    stars.addAll(List<Widget>.filled(value.toInt(), Icon(Icons.star, size: 15, color: Colors.amberAccent)));
    stars.addAll(List<Widget>.filled(5-value.toInt(), Icon(Icons.star, size: 15, color: _noneColor)));
    stars.add(SizedBox(width: 5));
    stars.add(Text(item.create_time.substring(0,10), style: TextStyle(fontSize: 12)));
    return Row(
      children: stars,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  Widget get _countWidget {
    var num = item.useful_count;
    var text = num.toString();
    if ( num >= 10000) {
      num /= 10000;
      text = num.toStringAsFixed(1) + '万';
    }
    return Text(text,
        style: TextStyle(color: _countColor));
  }

}


import 'package:douban/util/localization_manager.dart';
import 'package:douban/view/base_view.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MovieWebView extends StatefulWidget {

  String url;
  String title;

  static open(BuildContext context,  String url, {String title}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieWebView(url, title: title)
        )
    );
  }

  MovieWebView(this.url, {this.title});

  @override
  _MovieWebViewState createState() => _MovieWebViewState();
}

class _MovieWebViewState extends State<MovieWebView> {


  bool _isFinish = false;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          title: Text(_isFinish ? widget.title:LocalizationManger.i18n(context, 'movie.loading')),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: (){
                Share.share('${widget.title}\n${widget.url}');
              },
            )
          ],
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: Uri.encodeFull(widget.url),
            onPageStarted: (_) {
              setState(() {
                _isFinish = false;
              });
            },
            onPageFinished: (_) {
              setState(() {
                _isFinish = true;
              });
            },
          ),
          _isFinish ? Stack() : LoadingIndicator()
        ],
      )

    );
  }

}



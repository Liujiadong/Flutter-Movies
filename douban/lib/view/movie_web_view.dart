import 'dart:math';

import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text(
          _isFinish ? widget.title:LocalizationManger.i18n(context, 'movie.loading'),
          style: TextStyle(fontSize: 15), maxLines: 3)
      ),
      body: WebView(
        initialUrl: widget.url,
        navigationDelegate: (request) {
          final url = Uri.decodeComponent(request.url);
          final target = 'movie.douban.com/subject/';


          if (url.contains(target)) {

            String id = Uri.parse(url).queryParameters['url'].split(target).last.replaceAll('/', '');

            if (id.isNotEmpty) {
              RouterManager.navigateTo(context, RouterType.detail, params: 'id=$id');
            }

            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }



        },
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
      )
    );
  }

}



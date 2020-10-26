import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/view/refresh_view.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebpageView extends StatefulWidget {

  String url;
  String title;

  static open(BuildContext context,  String url, {String title}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebpageView(url, title: title)
        )
    );
  }

  WebpageView(this.url, {this.title});

  @override
  _WebpageViewState createState() => _WebpageViewState();
}

class _WebpageViewState extends State<WebpageView> {


  bool _isFinish = false;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
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
          _isFinish ? Stack() : RefreshCircularIndicator()
        ],
      )

    );
  }

}



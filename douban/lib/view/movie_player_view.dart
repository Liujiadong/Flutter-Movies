
import 'package:chewie/chewie.dart';
import 'package:douban/util/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class MoviePlayerView extends StatefulWidget {
  static open(BuildContext context, String url, {String title}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MoviePlayerView(url, title: title);
    }));
  }


  String url;
  String title;

  MoviePlayerView(this.url,{this.title});

  @override
  _MoviePlayerViewState createState() => _MoviePlayerViewState();
}

class _MoviePlayerViewState extends State<MoviePlayerView> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => RouterManager.pop(context),
                    ),
                    FlatButton(
                      child: Icon(Icons.share, color: Colors.white, size: 30),
                      onPressed: () {
                        Share.share('${widget.title}\n${widget.url}');
                      },
                    )
              ],
            ),
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            )
          ],
        )));
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    _chewieController.dispose();

    super.dispose();
  }
}

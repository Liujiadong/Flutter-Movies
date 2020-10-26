
import 'package:chewie/chewie.dart';
import 'package:movies/util/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';

class PlayerView extends StatefulWidget {

  static open(BuildContext context, String url, {String title}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlayerView(url, title: title);
    }));
  }


  final String url;
  final String title;

  PlayerView(this.url,{this.title});

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {

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

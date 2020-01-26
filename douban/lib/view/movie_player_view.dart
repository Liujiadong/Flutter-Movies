import 'package:chewie/chewie.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/util/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MoviePlayerView extends StatefulWidget {

  static open(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
               return MoviePlayerView(url);
            })
    );
  }

  String url;

  MoviePlayerView(this.url);

  @override
  _MoviePlayerViewState createState() => _MoviePlayerViewState();
}

class _MoviePlayerViewState extends State<MoviePlayerView> {

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;


  get url {
    return widget.url.replaceAll('http', 'https');
  }

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(url);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      materialProgressColors: ChewieProgressColors(playedColor: ConstColor.theme ,handleColor: ConstColor.theme),
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                Chewie(
                    controller: chewieController
                ),
                FlatButton(
                  child: Icon(Icons.close, color: Colors.white, size: 30),
                  padding: EdgeInsets.only(right: 30, bottom: 30),
                  onPressed: () => RouterManager.pop(context),
                )
              ],
            )
        )
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}

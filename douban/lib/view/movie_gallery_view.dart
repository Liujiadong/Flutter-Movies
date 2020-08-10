import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/util/router_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MovieGalleryView extends StatefulWidget {


  static open(BuildContext context, List<MovieGalleryItem> galleryItems, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieGalleryView(galleryItems, index)
        )
    );
  }

  final List<MovieGalleryItem> galleryItems;
  final PageController pageController;
  final int index;

  MovieGalleryView(this.galleryItems, this.index) : pageController = PageController(initialPage: index);

  @override
  _MovieGalleryViewState createState() => _MovieGalleryViewState();
}

class _MovieGalleryViewState extends State<MovieGalleryView> {

  int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    currentIndex = widget.index;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                PhotoViewGallery.builder(
                  scrollPhysics: BouncingScrollPhysics(),
                    itemCount: widget.galleryItems.length,
                    loadingBuilder: (context, _){
                      return  CupertinoActivityIndicator();
                    },
                    loadFailedChild: CupertinoActivityIndicator(),
                    pageController: widget.pageController,
                    onPageChanged: onPageChanged,
                    builder: _buildItem),
                Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FlatButton(
                              child: Icon(Icons.close, color: Colors.white, size: 30),
                              onPressed: () => RouterManager.pop(context),
                            )
                          ],
                        ),
                        Text(
                          "${currentIndex + 1} / ${widget.galleryItems.length}",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                )

              ],
            )
        )
    );

  }

  onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  PhotoViewGalleryPageOptions _buildItem(
      BuildContext context, int index) {
    final galleryItem = widget.galleryItems[index];

    return PhotoViewGalleryPageOptions(
      imageProvider: galleryItem.provider,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
    );
  }

}

class MovieGalleryItem {

  String id;
  String url;

  MovieGalleryItem(
      this.id,
      this.url);

  ImageProvider get provider {
    return CachedNetworkImageProvider(url);
  }

}

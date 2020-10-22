import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/model/base_model.dart';
import 'package:movies/util/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:movies/view/refresh_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryView extends StatefulWidget {



  static open(BuildContext context, List<GalleryItem> galleryItems, int index) {

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GalleryView(galleryItems, index)
        )
    );
  }

  final List<GalleryItem> galleryItems;
  final int index;

  GalleryView(this.galleryItems, this.index);

  @override
  _GalleryViewState createState() => _GalleryViewState();

}

class _GalleryViewState extends State<GalleryView> {

  int _currentIndex;
  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = widget.index;
    _pageController = PageController(initialPage: widget.index);

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
                      return  RefreshCircularIndicator();
                    },
                    pageController: _pageController,
                    onPageChanged: _onPageChanged,
                    builder: _itemView),
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
                          "${_currentIndex + 1} / ${widget.galleryItems.length}",
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

  _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  PhotoViewGalleryPageOptions _itemView(
      BuildContext context, int index) {
    final galleryItem = widget.galleryItems[index];

    final imageProvider = CachedNetworkImageProvider(galleryItem.url);


    return PhotoViewGalleryPageOptions(
      imageProvider: imageProvider,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
    );
  }

}

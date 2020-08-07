import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/staff_model.dart';
import 'package:flutter/material.dart';
import 'movie_gallery_view.dart';

class MovieStaffView extends StatelessWidget {

  List<StaffModel> staffs;
  BuildContext _context;
  EdgeInsetsGeometry margin;
  double height;


  List<MovieGalleryItem> get galleryItems {
    return staffs.map((v) {
      return MovieGalleryItem('staff_${v.id}', v.largeImage);
    }).toList();
  }

  MovieStaffView(
      this.staffs,
      {this.margin = const EdgeInsets.only(top: 5),
        this.height = 150});

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Container(
        margin: margin,
        height: height,
        child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 10,
          children: staffs
              .map((staff) { return _item(staff); })
              .toList(),
        )
    );

  }

  Widget _item(StaffModel staff) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _imageWidget(staff),
          Text(staff.name, style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
          Text(staff.title, style: TextStyle(fontSize: 9, color: Colors.white70))
        ],
      ),
    );
  }

  Widget _imageWidget(StaffModel staff) {

    final index = staffs.indexOf(staff);

    return
      Container(
        height: 118,
        width: 100,
        child: GestureDetector(
          onTap: () {
            MovieGalleryView.open(_context, galleryItems, index);
          },
          child: CachedNetworkImage(imageUrl: staff.largeImage, fit: BoxFit.cover)
        ),
      );
  }
}

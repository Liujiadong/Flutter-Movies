import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/model/base_model.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:flutter/material.dart';
import '../base_view.dart';
import '../gallery_view.dart';

class MovieStaffView extends StatelessWidget {

  final List<MovieStaff> staffs;


  List<GalleryItem> get galleryItems {
    return staffs.map((v) {
      return GalleryItem('staff_${v.id}', v.avatar);
    }).toList();
  }

  MovieStaffView(this.staffs);

  @override
  Widget build(BuildContext context) {

    final _staffs = staffs.where((staff) {
      return staff.avatar != null;
    }).toList();

    if (_staffs.isNotEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              BaseTitleView('movie.casts'),
              Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 150,
                  child: GridView.count(
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 10,
                    children: _staffs
                        .map((staff) { return _itemView(context ,staff);})
                        .toList(),
                  )
              )
            ],
          ));
    }
    return SizedBox();


  }

  Widget _itemView(BuildContext context,MovieStaff staff) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _imageView(context,staff),
          Text(staff.name, style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
          Text(LocalizationManger.i18n(context, staff.title), style: TextStyle(fontSize: 9, color: Colors.white70))
        ],
      ),
    );
  }

  Widget _imageView(BuildContext context, MovieStaff staff) {

    final index = staffs.indexOf(staff);

    return
      Container(
        height: 118,
        width: 100,
        child: GestureDetector(
          onTap: () {
            GalleryView.open(context, galleryItems, index);
          },
          child: CachedNetworkImage(imageUrl: staff.avatar, fit: BoxFit.cover)
        ),
      );
  }
}

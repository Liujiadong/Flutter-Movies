import 'package:movies/util/localization_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PhotosView extends StatelessWidget {

  String id, title;


  PhotosView(this.id, this.title);

  final _refreshController = RefreshController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _scaffoldkey,
        appBar: AppBar(title: Text(LocalizationManger.i18n(context, 'movie.photos'))),
        body: SmartRefresher(
          controller: _refreshController,
          header: RefreshHeader(),
          footer: RefreshFooter(),
          enablePullUp: false,
          enablePullDown: false,
          // onRefresh: model.onRefresh,
          // onLoading: model.onLoading,
          child: _body(context),
        )
    );


  }


  _body(BuildContext context) {


    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.green,
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: Colors.white,
              child: new Text('$index'),
            ),
          )),
      staggeredTileBuilder: (index) {
        return StaggeredTile.fit(1);
      },
      mainAxisSpacing: 0.5,
      crossAxisSpacing: 0.5,
    );
  }

}

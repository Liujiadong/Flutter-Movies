import 'package:movies/model/comment_model.dart';
import 'package:movies/model/movie_model.dart';
import 'package:movies/util/localization_manager.dart';
import 'package:movies/util/provider_manager.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/movie_comment_view.dart';
import 'package:movies/view_model/movie_view_model.dart';
import 'package:movies/view/movie_web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentsView extends StatelessWidget {

  String id, title;

  final _refreshController = RefreshController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  CommentsView(this.id, this.title);

  String get extra {
    return path(RouterType.comments);
  }

  String get titleKey {
    return 'movie.comments';
  }

  @override
  Widget build(BuildContext context) {


    return ProviderWidget<MovieCommentViewModel>(
        model: MovieCommentViewModel(id, extra),
        builder: (context, model, _) {
          return Scaffold(
            key: _scaffoldkey,
              appBar: AppBar(title: Text(LocalizationManger.i18n(context, titleKey))),
              body: SmartRefresher(
                controller: _refreshController,
                header: RefreshHeader(),
                footer: RefreshFooter(),
                enablePullUp: !model.refreshNoData,
                enablePullDown: !model.refreshNoData,
                onRefresh: model.onRefresh,
                onLoading: model.onLoading,
                child: _body(context, model),
              )
          );
        }
    );
  }

  Widget _body(BuildContext context, MovieCommentViewModel model) {

    return baseRefreshView(
        model: model,
        scaffoldkey: _scaffoldkey,
        refreshController: _refreshController,
        builder: () {

          final list = model.list;

          return ListView.builder(
              itemCount: list.subjects.length ?? 0,
              itemBuilder: (context, index) {

                CommentListItem item =  list.subjects[index];

                return Card(
                    child: InkWell(
                      child: Container(
                        child: MovieCommentView(item),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      onTap: () {
                        if (item.url != null) {
                          MovieWebView.open(context, item.url, title: title);
                        }
                      },
                    )
                );
              });
        },
    );

  }
}

import 'package:douban/model/movie_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/movie_comment_view.dart';
import 'package:douban/view/movie_web_view.dart';
import 'package:douban/view_model/comment_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentsView extends StatelessWidget {

  String id, title;

  final _refreshController = RefreshController();

  CommentsView(this.id, this.title);

  String get extra {
    return path(RouterType.comments);
  }

  String get titleKey {
    return 'movie.comments';
  }

  @override
  Widget build(BuildContext context) {


    return ProviderWidget<CommentViewModel>(
        model: CommentViewModel(id, extra),
        builder: (context, model, _) {
          return Scaffold(
              appBar: AppBar(title: Text(LocalizationManger.i18n(context, titleKey))),
              body: SmartRefresher(
                controller: _refreshController,
                header: RefreshHeader(),
                footer: RefreshFooter(),
                enablePullUp: model.comments != null,
                onRefresh: () async {
                  model.onRefresh();
                },
                onLoading:  () async {
                  model.onLoading();
                },
                child: _body(context, model),
              )
          );
        }
    );
  }

  Widget _body(BuildContext context, CommentViewModel model) {

    final state = model.viewState;
    final comments = model.comments;


    if (state == ViewState.onRefresh) {
      _refreshController.resetNoData();
      if (model.refreshNoData) {
        return LoadingIndicator();
      }
    }

    if (state == ViewState.refreshCompleted) {
      _refreshController.refreshCompleted();
    }

    if (state == ViewState.refreshError) {
      return ErrorView(model.message, () {
        model.onRefresh();
      });
    }

    if (state == ViewState.empty) {
      return ErrorView(LocalizationManger.i18n(context, 'refresh.empty'), () {
        model.onRefresh();
      });
    }

    if (state == ViewState.onLoading) {
      _refreshController.refreshToIdle();
    }

    if (state == ViewState.loadNoData) {
      _refreshController.loadNoData();
    }

    if (state == ViewState.loadComplete) {
      _refreshController.loadComplete();
    }

    return ListView.builder(
        itemCount: comments.subjects.length ?? 0,
        itemBuilder: (context, index) {
          CommentItem _comment =  comments.subjects[index];

          return Card(
              child: InkWell(
                child: Container(
                  child: MovieCommentView(_comment),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                onTap: () {
                  if (_comment.url != null) {
                    MovieWebView.open(context, _comment.url, title: title);
                  }
                },
              )
          );
        });
  }
}

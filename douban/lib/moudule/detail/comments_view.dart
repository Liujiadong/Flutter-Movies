import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/list_loading_view.dart';
import 'package:douban/view/movie_comment_view.dart';
import 'package:douban/view/movie_web_view.dart';
import 'package:douban/view_model/comment_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentsView extends StatelessWidget {

  String id;
  BuildContext _context;
  final refreshController = RefreshController();

  CommentsView(this.id);

  String get extra {
    return path(RouterType.comments);
  }

  String get titleKey {
    return 'movie.comments';
  }

  @override
  Widget build(BuildContext context) {


    _context = context;


    return ProviderWidget<CommentViewModel>(
        model: CommentViewModel(id, extra),
        builder: (context, model, _) {
          return Scaffold(
              appBar: AppBar(title: Text(LocalizationManger.i18n(_context, titleKey))),
              body: SmartRefresher(
                controller: refreshController,
                header: RefreshHeader(),
                footer: RefreshFooter(),
                enablePullUp: model.comments != null,
                onRefresh: () async {
                  model.onRefresh();
                },
                onLoading:  () async {
                  model.onLoading();
                },
                child: _body(model),
              )
          );
        }
    );
  }

  Widget _body(CommentViewModel model) {

    final viewState = model.viewState;
    final comments = model.comments;

    Widget _body;

    switch (viewState) {
      case ViewState.onRefresh:
        refreshController.resetNoData();
        _body = ListLoadingView();
        break;
      case ViewState.refreshCompleted:
        refreshController.refreshCompleted();
        break;
      case ViewState.onLoading:
        refreshController.refreshToIdle();
        break;
      case ViewState.loadNoData:
        refreshController.loadNoData();
        break;
      case ViewState.loadComplete:
        refreshController.loadComplete();
        break;
      default:
        _body = Text('Error');
    }

    return _body ?? ListView.builder(
        itemCount: comments.subjects.length ?? 0,
        itemBuilder: (context, index) {
          final _comment =  comments.subjects[index];

          return Card(
              child: InkWell(
                child: Container(
                  child: MovieCommentView(
                      _comment,
                      showDivider: false,
                      showMultiTheme: true),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                onTap: () {
                  String title = _comment['title'];
                  String url = _comment['share_url'] ?? '';
                  if (url.isNotEmpty) {
                    MovieWebView.open(context, url, title: title);
                  }
                },
              )
          );
        });
  }
}

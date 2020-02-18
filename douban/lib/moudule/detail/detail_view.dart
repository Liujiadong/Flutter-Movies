import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
import 'package:douban/view/movie_comment_view.dart';
import 'package:douban/view/movie_loading_view.dart';
import 'package:douban/view/movie_staff_view.dart';
import 'package:douban/view/movie_trailers_view.dart';
import 'package:douban/view_model/movie_view_model.dart';
import 'package:douban/view_model/viewState_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:douban/view_model/theme_view_model.dart';

class DetailView extends StatelessWidget {

  String id;
  MovieModel _movie;
  BuildContext _context;

  DetailView(this.id);

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<ThemeViewModel>(context);
    _context = context;

    return ProviderWidget<MovieViewModel>(
      model: MovieViewModel(id),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: theme.isDark ?  theme.data.primaryColor :model.coverColor,
            title: Text(model.title),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Text(LocalizationManger.i18n(context, 'movie.review'),
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    RouterManager.navigateTo(_context, RouterType.reviews,
                        params: 'id=${_movie.id}');
                  })
            ],
          ),
          body: _body(model),
          backgroundColor: theme.isDark ?  theme.data.primaryColor :model.coverColor,
        );
      },
    );
  }

  Widget _body(MovieViewModel model) {

    final viewState = model.viewState;
    _movie = model.movie;

    if (viewState == ViewState.onRefresh) {
      return MovieLoadingView();
    }

    if (viewState == ViewState.refreshError) {
      return ErrorView(model.message, () {
        model.fetch();
      });
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
            return Column(
              children: <Widget>[
                _coverWidget,
                _rateWidget,
                _summaryWidget,
                _staffWidget,
                _trailersWidget,
                _commentsWidget
              ],
            );
          }, childCount: 1),
        )
      ],
    );
  }

  Widget get _coverWidget {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(_movie.largeImage),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5,
                )
              ]),
          width: 135,
          height: 200,
          margin: EdgeInsets.only(top: 15),
        )
      ],
    );
  }

  Widget get _rateWidget {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(5)),
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RatingLabel(_movie.rating.average.toString(),
                  normalSize: 25,
                  noneSize: 15,
                  normalColor: Colors.white),
              RatingStar(
                _movie.rating.fullCount,
                  Icon(Icons.star, size: 20, color: Colors.amberAccent),
                _movie.rating.emptyCount,
                Icon(Icons.star_border, size: 20, color: Colors.amberAccent),
                halfCount: _movie.rating.halfCount,
                halfIcon: Icon(Icons.star_half,size: 20, color: Colors.amberAccent),
              )
            ],
          ),
          RatingDesView(_movie)
        ],
      ),
    );
  }


  Widget get _summaryWidget {


    if (_movie.summary.isNotEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleWighet(LocalizationManger.i18n(_context, 'movie.summary')),
              Text(_movie.summary,
                  style: TextStyle(color: Colors.white, fontSize: 13))
            ],
          )
      );
    }
    return SizedBox();

   // return
  }


  Widget get _staffWidget {

    final staffs = _movie.staffs
        .where((staff) {
          return staff.avatars != null;
        })
        .toList();

    if (staffs.isNotEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleWighet(LocalizationManger.i18n(_context, 'movie.casts')),
              MovieStaffView(staffs)
            ],
          ));
    }

    return SizedBox();
  }


  Widget get _trailersWidget {

    if (_movie.photos.isNotEmpty && _movie.videos.isNotEmpty) {

      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleWighet(LocalizationManger.i18n(_context, 'movie.trailers')),
              MovieTrailersView(_movie.photos, _movie.videos)
            ],
          )
      );
    }

    return SizedBox();
  }

  Widget get _commentsWidget {

    if (_movie.popular_comments.isNotEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _titleWighet(LocalizationManger.i18n(_context, 'movie.comments')),
                  FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: <Widget>[
                          Text('${LocalizationManger.i18n(_context, 'movie.comments_all')} ${_movie.comments_count}',
                              style: TextStyle(color: Colors.white)),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_ios,
                              size: 15, color: Colors.white)
                        ],
                      ),
                      onPressed: () {
                        RouterManager.navigateTo(_context, RouterType.comments,
                            params: 'id=${_movie.id}');
                      }
                  )
                ],
              ),
              ..._movie.popular_comments
                  .map((v) {
                return MovieCommentView(v);
              }).toList(),
            ],
          )
      );
    }

    return SizedBox();

  }

  Widget _titleWighet(text) {
    return Container(
      child: Text(text,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      margin: EdgeInsets.only(bottom: 5),
    );
  }
}

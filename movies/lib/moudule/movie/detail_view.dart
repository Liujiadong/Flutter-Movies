import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies/model/movie_model.dart';

import 'package:movies/util/localization_manager.dart';
import 'package:movies/util/provider_manager.dart';
import 'package:movies/util/router_manager.dart';
import 'package:movies/view/base_view.dart';
import 'package:movies/view/error_view.dart';
import 'package:movies/view/movie/movie_rating_view.dart';
import 'package:movies/view/movie/movie_recommend_view.dart';
import 'package:movies/view/movie/movie_staff_view.dart';
import 'package:movies/view/movie/movie_trailer_view.dart';
import 'package:movies/view/rating_view.dart';
import 'package:movies/view_model/movie_view_model.dart';
import 'package:movies/view_model/base_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies/view_model/theme_view_model.dart';

// ignore: must_be_immutable
class DetailView extends StatelessWidget {
  final String id;
  final String title;
  Movie _movie;
  BuildContext _context;

  DetailView(this.id, this.title);

  @override
  Widget build(BuildContext context) {

    final _theme = Provider.of<ThemeViewModel>(context, listen: false);
    final _themeData = _theme.data(context);
    final _isDark = _theme.isDark(context);
    _context = context;

    return ProviderWidget<MovieViewModel>(
      model: MovieViewModel(id),
      builder: (context, model, _) {

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: _isDark ? _themeData.primaryColor : model.color,
            title: Text(title),
            centerTitle: true,
            actions: _actionButtons(model),
          ),
          body: SafeArea(
            child: _body(model),
          ),
          backgroundColor:
              _isDark ? _themeData.scaffoldBackgroundColor : model.color,
        );
      },
    );
  }

  List<Widget> _actionButtons(MovieViewModel model) {

    if (model.viewState != ViewState.refreshCompleted) {
      return [];
    }

    return [
      Row(
        children: [
          IconButton(
              icon: Icon(Icons.movie_filter),
              onPressed: () {
                return showModalBottomSheet(context: _context, builder: (_) {
                  return MovieRecommendView(id);
                });
              })
        ],
      )
    ];

  }

  Widget _body(MovieViewModel model) {

    final state = model.viewState;
    _movie = model.movie;

    if (state == ViewState.onRefresh) {
      return CircularIndicator();
    }

    if (state == ViewState.refreshError) {
      return ErrorView(model.message, onRefresh: model.onRefresh);
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Column(
              children: <Widget>[
                _coverWidget,
                MovieRatingView(_movie),
                _summaryWidget,
                _staffWidget,
                _trailersWidget,
                _reviewWidget
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
                  image: CachedNetworkImageProvider(_movie.cover),
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
  

  Widget get _summaryWidget {
    if (_movie.intro.isNotEmpty) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleWighet(LocalizationManger.i18n(_context, 'movie.summary')),
              Text(_movie.intro,
                  style: TextStyle(color: Colors.white, fontSize: 13))
            ],
          ));
    }
    return SizedBox();
    // return
  }

  Widget get _staffWidget {

    final staffs = _movie.staffs.where((staff) {
      return staff.avatar != null;
    }).toList();

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
    if (_movie.trailer != null) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _titleWighet(LocalizationManger.i18n(_context, 'movie.trailers')),
              MovieTrailerView(_movie.trailer, _movie.title),
            ],
          ));
    }
    return SizedBox();
  }

  Widget get _reviewWidget {

    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            ListTile(
                title: _titleWighet(LocalizationManger.i18n(_context, 'movie.photos')),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  RouterManager.toMovie(_context, RouterType.photos, _movie.id, _movie.title);
                }),
            ListTile(
                title: _titleWighet(LocalizationManger.i18n(_context, 'movie.comments')),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  RouterManager.toMovie(_context, RouterType.comments, _movie.id, _movie.title);
                }),
            ListTile(
                title: _titleWighet(LocalizationManger.i18n(_context, 'movie.review')),
                trailing: Icon(Icons.chevron_right, color: Colors.white),
                onTap: () {
                  RouterManager.toMovie(_context, RouterType.reviews, _movie.id, _movie.title);
                }),
          ],
        )
    );
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

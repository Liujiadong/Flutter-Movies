import 'package:cached_network_image/cached_network_image.dart';
import 'package:douban/model/movie_model.dart';
import 'package:douban/moudule/movie/recommend_view.dart';
import 'package:douban/util/localization_manager.dart';
import 'package:douban/util/provider_manager.dart';
import 'package:douban/util/router_manager.dart';
import 'package:douban/view/base_view.dart';
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
  String title;
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
                  return RecommendView(id);
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
      return LoadingIndicator();
    }

    if (state == ViewState.refreshError) {
      return ErrorView(model.message, () {
        model.onRefresh();
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

  Widget get _rateWidget {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(5)),
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RatingLabel(_movie.rating.value.toString(),
                    normalSize: 25, noneSize: 15, normalColor: Colors.white),
                RatingStar(
                  _movie.rating.fullCount,
                  Icon(Icons.star, size: 20, color: Colors.amberAccent),
                  _movie.rating.emptyCount,
                  Icon(Icons.star_border, size: 20, color: Colors.amberAccent),
                  halfCount: _movie.rating.halfCount,
                  halfIcon: Icon(Icons.star_half,
                      size: 20, color: Colors.amberAccent),
                ),
                Text(
                    '${_movie.rating.count} ${LocalizationManger.i18n(_context, 'movie.scored')}',
                    style: TextStyle(fontSize: 10, color: Colors.white))
              ],
            ),
          ),
          RatingDesView(_movie)
        ],
      ),
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

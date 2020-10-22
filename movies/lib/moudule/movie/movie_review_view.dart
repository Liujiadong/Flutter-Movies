import 'package:movies/util/router_manager.dart';
import 'movie_comment_view.dart';


class MovieReviewView extends MovieCommentView {

  MovieReviewView(String id, String title) : super(id, title);

  @override
  String get extra {
    return  path(RouterType.reviews);
  }

  @override
  String get titleKey {
    return 'movie.review';
  }

}

import 'package:movies/util/router_manager.dart';
import 'comments_view.dart';


class ReviewsView extends CommentsView {

  ReviewsView(String id, String title) : super(id, title);

  @override
  String get extra {
    return  path(RouterType.reviews);
  }

  @override
  String get titleKey {
    return 'movie.review';
  }

}

import 'package:douban/moudule/detail/comments_view.dart';
import 'package:douban/util/router_manager.dart';


class ReviewsView extends CommentsView {
  ReviewsView(String id) : super(id);

  @override
  String get extra {
    return  path(RouterType.reviews);
  }

  @override
  String get titleKey {
    return 'movie.review';
  }

}

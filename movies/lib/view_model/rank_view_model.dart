import 'package:movies/model/rank_model.dart';
import 'package:movies/util/constant.dart';
import 'package:movies/view_model/base_view_model.dart';


class RankViewModel extends BaseViewModel {

  RankList list;

  RankViewModel() {
    onRefresh();
  }

  @override
  bool get isEmpty => list.subjects.isEmpty;

  @override
  String get api => Api.fetchRanks;

  @override
  bool get refreshNoData {
    if (list != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  refreshCompleted(json) {
    list = RankList.fromJson(json);
  }

}

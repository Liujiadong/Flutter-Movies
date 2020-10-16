import 'package:douban/model/list_model.dart';
import 'package:douban/util/constant.dart';
import 'package:douban/view_model/base_view_model.dart';


class RankViewModel extends BaseViewModel {

  Ranks ranks;

  RankViewModel() {
    onRefresh();
  }

  @override
  bool get isEmpty => ranks.subjects.isEmpty;

  @override
  String get api => Api.fetchRanks;

  @override
  bool get refreshNoData {
    if (ranks != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  refreshCompleted(json) {
    ranks = Ranks.fromJson(json);
  }

}

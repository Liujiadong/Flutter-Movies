import 'package:movies/model/base_model.dart';
import 'package:movies/util/constant.dart';
import 'package:dio/dio.dart';
import 'package:movies/util/network_manager.dart';
import 'package:flutter/cupertino.dart';


class BaseListViewModel<T extends BaseList> extends BaseViewModel {

  T list;

  final String id;
  int start = 0;
  int count = 10;

  int _start;

  BaseListViewModel({this.id = ''}){
    onRefresh();
  }

  @override
  get data => {
    'start': _start,
    'count': count,
    'id': id
  };

  @override
  bool get refreshNoData {
    if (list != null) {
      return isEmpty;
    }
    return true;
  }

  @override
  bool get isEmpty => list.subjects.isEmpty;

  @override
  bool get loadNoData => list.subjects.length >= list.total;

  @override
  onRefresh() {
    _start = start;
    super.onRefresh();
  }

  @override
  onLoading() {
    _start = list.subjects.length;
    super.onLoading();
  }

  T modelFromJson(json) {
    return BaseList.fromJson(json) as T;
  }

  @override
  refreshCompleted(json) {
    list =  modelFromJson(json);
  }

  @override
  loadComplete(json) {
    final _list = modelFromJson(json);
    list.subjects.addAll(_list.subjects);
  }


}


class BaseViewModel extends StateViewModel {

   bool get isEmpty { return false; }
   bool get refreshNoData { return false; }
   bool get loadNoData { return false; }

   String get api { return Api.fetchMovie; }
   String get extra { return ''; }
   Map<String, dynamic> get data { return {}; }

   onRefresh() {
     setViewState(ViewState.onRefresh);
     _response.then((response) {
       refreshCompleted(response.data);
       setViewState(ViewState.refreshCompleted);
       if (isEmpty) {
         setViewState(ViewState.empty, message: 'refresh.empty');
       }
     }, onError:(error) {
       setViewState(ViewState.refreshError, message: error.message);
     });
   }

   onLoading() {
     if (loadNoData) {
       setViewState(ViewState.loadNoData);
     } else {
       setViewState(ViewState.onLoading);
       _response.then((response) {
         loadComplete(response.data);
         setViewState(ViewState.loadComplete);
       }, onError: (error) {
         setViewState(ViewState.loadError, message: error.message);
       });
     }
   }


   refreshCompleted(json) {

   }

   loadComplete(json) {

   }

   Future<Response> get _response async {
     return await NetworkManager.get(api,
         extra: extra,
         data: data);
   }

}



enum ViewState {
  idle,
  onRefresh,
  refreshCompleted,
  refreshError,
  onLoading,
  loadComplete,
  loadNoData,
  loadError,
  empty
}

class StateViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.idle;

  String _message;

  setViewState(ViewState viewState, {String message}) {
    _viewState = viewState;
    _message = message;
    notifyListeners();
  }

  ViewState get viewState => _viewState;

  String get message => _message;

}
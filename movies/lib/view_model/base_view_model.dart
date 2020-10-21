import 'package:movies/util/constant.dart';
import 'package:dio/dio.dart';
import 'package:movies/util/network_manager.dart';
import 'package:flutter/cupertino.dart';


class BaseViewModel extends ViewStateViewModel {

   bool get isEmpty { return false; }
   bool get refreshNoData { return false; }
   bool get loadNoData { return false; }

   String get api { return Api.fetchMovieList; }
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

class ViewStateViewModel extends ChangeNotifier {
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
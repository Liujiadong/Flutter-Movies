import 'package:douban/util/constant.dart';
import 'package:dio/dio.dart';
import 'package:douban/util/network_manager.dart';
import 'package:douban/view_model/viewState_view_model.dart';

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
         setViewState(ViewState.empty);
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

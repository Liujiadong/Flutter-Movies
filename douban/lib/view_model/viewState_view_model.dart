import 'package:flutter/material.dart';

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

  get viewState => _viewState;

  get message => _message;



}
import 'package:douban/view_model/language_view_model.dart';
import 'package:douban/view_model/theme_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => ThemeViewModel()),
  ChangeNotifierProvider(create: (_) => LanguageViewModel())
];

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget child;

  ProviderWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
  }) : super(key: key);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    model = widget.model;

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
        value: model,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ));
  }
}

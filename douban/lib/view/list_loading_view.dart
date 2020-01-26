import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ListLoadingView extends StatelessWidget {

  ListLoadingView({this.count, this.itemWidget});

  final int count;
  final Widget itemWidget;

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Shimmer.fromColors(
            period: Duration(milliseconds: 1200),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              children: List(this.count ?? 6).map((_) => itemWidget ?? ListLoadingItemView()).toList(),
            )
        )
    );

  }
}

class ListLoadingItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Container(
          height: 130,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 120,
                width: 100,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 20,
                      width: 80,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 20,
                      width: 100,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 20,
                      width: 150,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class MovieLoadingView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Shimmer.fromColors(
            period: Duration(milliseconds: 1200),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 135,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      height: 120,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 30,
                          width: 80,
                          color: Colors.white,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 20,
                          color: Colors.white,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 20,
                          color: Colors.white,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 20,
                          color: Colors.white,
                        )
                      ],
                    )

                  ],
                ),
              ),
            )
        )
    );

  }
}


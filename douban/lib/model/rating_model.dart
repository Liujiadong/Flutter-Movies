class RatingModel {
  num average;
  String stars;
  Map details;

  get fullCount {
    return num.parse(stars[0]).toInt();
  }

  get halfCount {
    return num.parse(stars[1]) ~/ 5;
  }

  get emptyCount {
    return 5 - fullCount - halfCount;
  }


  RatingModel(
      this.average,
      this.stars,
      this.details,
      );

  RatingModel.fromJson(json) {
    average = json['average'];
    stars = json['stars'];
    details = json['details'];
  }

}
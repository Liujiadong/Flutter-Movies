class BaseList {

  num count;
  num start;
  num total;
  List subjects;

  String id;
  String name;

  BaseList.fromJson(json){

    count = json['count'];
    start = json['start'];
    total = json['total'];

  }

}
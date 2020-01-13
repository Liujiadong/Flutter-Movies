class StaffModel {
  String name;
  String id;
  String alt;
  Map avatars;
  String title;

  get largeImage {
    return avatars["large"];
  }

  StaffModel({
    this.name,
    this.id,
    this.avatars,
    this.alt
  });

  StaffModel.fromJson(json) {
    name = json['name'];
    id = json['id'];
    avatars = json['avatars'];
    alt = json['alt'];
  }


}
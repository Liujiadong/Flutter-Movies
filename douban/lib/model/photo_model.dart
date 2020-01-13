class PhotoModel {
  String id;
  String image;
  String cover;
  String icon;
  String alt;
  String thumb;

  PhotoModel(
      this.id,
      this.image,
      this.cover,
      this.icon,
      this.alt,
      this.thumb,
      );

  PhotoModel.fromJson(json) {
    image = json['image'];
    cover = json['cover'];
    id = json['id'];
    icon = json['icon'];
    alt = json['alt'];
    thumb = json['thumb'];
  }
}
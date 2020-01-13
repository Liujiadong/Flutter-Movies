class VideoModel {
  String id;
  String medium;
  String title;
  String resource_url;
  String subject_id;

  VideoModel(
      this.id,
      this.medium,
      this.title,
      this.resource_url,
      this.subject_id
      );

  VideoModel.fromJson(json) {
    subject_id = json['subject_id'];
    resource_url = json['resource_url'];
    id = json['id'];
    medium = json['medium'];
    title = json['title'];
  }

}

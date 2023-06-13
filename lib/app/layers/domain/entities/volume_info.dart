import 'package:my_books/app/layers/domain/entities/image_links.dart';

class VolumeInfo {
  String? title;
  String? description;
  ImageLinks? imageLinks;

  VolumeInfo({this.title, this.description, this.imageLinks});

  VolumeInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    imageLinks = json['imageLinks'] != null
        ? ImageLinks.fromJson(json['imageLinks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    if (imageLinks != null) {
      data['imageLinks'] = imageLinks!.toJson();
    }
    return data;
  }
}

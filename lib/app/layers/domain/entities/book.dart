import 'package:my_books/app/layers/domain/entities/sale_info.dart';
import 'package:my_books/app/layers/domain/entities/volume_info.dart';

class Book {
  String? id;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;

  Book({this.id, this.volumeInfo, this.saleInfo});

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    volumeInfo = json['volumeInfo'] != null
        ? VolumeInfo.fromJson(json['volumeInfo'])
        : null;
    saleInfo =
        json['saleInfo'] != null ? SaleInfo.fromJson(json['saleInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (volumeInfo != null) {
      data['volumeInfo'] = volumeInfo!.toJson();
    }
    if (saleInfo != null) {
      data['saleInfo'] = saleInfo!.toJson();
    }
    return data;
  }
}

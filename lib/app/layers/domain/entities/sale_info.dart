import 'package:my_books/app/layers/domain/entities/retail_price.dart';

class SaleInfo {
  String? buyLink;
  RetailPrice? retailPrice;

  SaleInfo({this.buyLink, this.retailPrice});

  SaleInfo.fromJson(Map<String, dynamic> json) {
    buyLink = json['buyLink'];
    retailPrice = json['retailPrice'] != null
        ? RetailPrice.fromJson(json['retailPrice'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['buyLink'] = buyLink;
    if (retailPrice != null) {
      data['retailPrice'] = retailPrice!.toJson();
    }
    return data;
  }
}

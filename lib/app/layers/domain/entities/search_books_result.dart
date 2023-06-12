class SearchBooksResult {
  int? totalItems;
  List<Item>? items;

  SearchBooksResult({this.totalItems = 0, this.items = const []});

  SearchBooksResult.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;

  Item({this.volumeInfo, this.saleInfo});

  Item.fromJson(Map<String, dynamic> json) {
    volumeInfo = json['volumeInfo'] != null
        ? VolumeInfo.fromJson(json['volumeInfo'])
        : null;
    saleInfo =
        json['saleInfo'] != null ? SaleInfo.fromJson(json['saleInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (volumeInfo != null) {
      data['volumeInfo'] = volumeInfo!.toJson();
    }
    if (saleInfo != null) {
      data['saleInfo'] = saleInfo!.toJson();
    }
    return data;
  }
}

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

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({this.smallThumbnail, this.thumbnail});

  ImageLinks.fromJson(Map<String, dynamic> json) {
    smallThumbnail = json['smallThumbnail'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['smallThumbnail'] = smallThumbnail;
    data['thumbnail'] = thumbnail;
    return data;
  }
}

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

class RetailPrice {
  double? amount;
  String? currencyCode;

  RetailPrice({this.amount, this.currencyCode});

  RetailPrice.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currencyCode'] = currencyCode;
    return data;
  }
}

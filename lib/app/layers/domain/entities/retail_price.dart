class RetailPrice {
  double? amount;
  String? currencyCode;

  RetailPrice({this.amount, this.currencyCode});

  RetailPrice.fromJson(Map<String, dynamic> json) {
    if (json['amount'] is int) {
      int amountInt = json['amount'];
      amount = amountInt.toDouble();
    } else {
      amount = json['amount'];
    }
    currencyCode = json['currencyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['currencyCode'] = currencyCode;
    return data;
  }
}

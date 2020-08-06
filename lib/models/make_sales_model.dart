class SalesData {
  List<SalesDataModel> salesDataModel;

  SalesData({this.salesDataModel});

  factory SalesData.fromJson(List<dynamic> parsedJson) {
    List<SalesDataModel> salesDataModel = List<SalesDataModel>();
    salesDataModel = parsedJson.map((i) => SalesDataModel.fromJson(i)).toList();

    return SalesData(
      salesDataModel: salesDataModel,
    );
  }
}

class SalesDataModel {
  final String colorName;
  final int colorQuantity;
  final int colorLimit;

  SalesDataModel({this.colorName, this.colorQuantity, this.colorLimit});

  SalesDataModel.fromJson(Map<String, dynamic> json)
      : colorName = json['name'],
        colorLimit = json['limit'],
        colorQuantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'name': this.colorName,
        'limit': this.colorLimit,
        'quantity': this.colorQuantity,
      };
}

class ColorsData {
  List<ColorDataModel> colorDataModel;

  ColorsData({this.colorDataModel});

  factory ColorsData.fromJson(List<dynamic> parsedJson) {
    List<ColorDataModel> colorDataModel = List<ColorDataModel>();
    colorDataModel = parsedJson.map((i) => ColorDataModel.fromJson(i)).toList();

    return ColorsData(
      colorDataModel: colorDataModel,
    );
  }
}

class ColorDataModel {
  final String colorName;
  final int colorQuantity;
  final int colorLimit;

  ColorDataModel({this.colorName, this.colorQuantity, this.colorLimit});

  ColorDataModel.fromJson(Map<String, dynamic> json)
      : colorName = json['name'],
        colorLimit = json['limit'],
        colorQuantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'name': this.colorName,
        'limit': this.colorLimit,
        'quantity': this.colorQuantity,
      };
}

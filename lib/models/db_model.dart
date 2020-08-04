class DataModel {
  List<DatabaseDataModel> databaseModel;

  DataModel({this.databaseModel});

  factory DataModel.fromJson(List<dynamic> parsedJson) {
    List<DatabaseDataModel> databaseModel = List<DatabaseDataModel>();
    databaseModel =
        parsedJson.map((i) => DatabaseDataModel.fromJson(i)).toList();

    return DataModel(
      databaseModel: databaseModel,
    );
  }
}

class DatabaseDataModel {
  final String productId;
  final String productName;
  final String productDescription;
  final String productUnitPrice;
  final String productQuantity;
  final String productUnitLimit;
  final String productPackPrice;
  final String productPackQuantity;
  final String productPackLimit;
  final String imageLink;
  final int weight;
  final String dateCreated;
  final String barcode;
  final int discount;
  final String category;

  DatabaseDataModel(
      {this.productId,
      this.productName,
      this.productDescription,
      this.productUnitPrice,
      this.productQuantity,
      this.productUnitLimit,
      this.productPackPrice,
      this.productPackLimit,
      this.productPackQuantity,
      this.imageLink,
      this.weight,
      this.dateCreated,
      this.discount,
      this.barcode,
      this.category});

  factory DatabaseDataModel.fromJson(Map<String, dynamic> json) {
    return DatabaseDataModel(
      productId: json['productId'],
      productName: json['name'],
      productDescription: json['description'],
      productUnitLimit: json['product_unit_limit'],
      productPackLimit: json['product_pack_limit'],
      productPackPrice: json['product_pack_price'],
      productPackQuantity: json['product_pack_quantity'],
      productQuantity: json['product_unit_quantity'],
      productUnitPrice: json['product_unit_price'],
      imageLink: json['image_link'],
      weight: json['weight'],
      dateCreated: json['date_created'],
      discount: json['discount'],
      barcode: json['bar_code'],
      category: json['category'],
    );
  }
}

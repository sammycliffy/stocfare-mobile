class ProductsAnalyticsList {
  List<ProductAnalyticsModel> productAnalyticsModel;

  ProductsAnalyticsList({this.productAnalyticsModel});

  factory ProductsAnalyticsList.fromJson(List<dynamic> parsedJson) {
    List<ProductAnalyticsModel> productAnalyticsModel =
        List<ProductAnalyticsModel>();
    productAnalyticsModel =
        parsedJson.map((i) => ProductAnalyticsModel.fromJson(i)).toList();

    return ProductsAnalyticsList(
      productAnalyticsModel: productAnalyticsModel,
    );
  }
}

class ProductAnalyticsModel {
  final String name;
  final int count;

  ProductAnalyticsModel({this.name, this.count});

  ProductAnalyticsModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        count = json['count'];
}

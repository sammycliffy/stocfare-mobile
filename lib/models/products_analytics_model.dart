class ProductsAnalyticsModel {
  String leastProductYearName;
  int leastProductSalesYearCount;
  String leastProductMonthName;
  int leastProductSalesMonthCount;
  String mostProductMonthName;
  int mostProductSalesMonthCount;
  String leastProductQuarterName;
  int leastProductSalesQuarterCount;
  String mostProductQuarterName;
  int mostProductSalesQuarterCount;
  String leastProductWeekName;
  int leastProductSalesWeekCount;
  String mostProductWeekName;
  int mostProductSalesWeekCount;

  ProductsAnalyticsModel({
    this.leastProductMonthName,
    this.leastProductQuarterName,
    this.leastProductSalesMonthCount,
    this.leastProductSalesQuarterCount,
    this.leastProductSalesWeekCount,
    this.leastProductSalesYearCount,
    this.leastProductWeekName,
    this.leastProductYearName,
    this.mostProductMonthName,
    this.mostProductQuarterName,
    this.mostProductSalesMonthCount,
    this.mostProductSalesQuarterCount,
    this.mostProductSalesWeekCount,
    this.mostProductWeekName,
  });

  factory ProductsAnalyticsModel.fromJson(Map<String, dynamic> json) {
    return ProductsAnalyticsModel(
      leastProductYearName: json['lease_sold_product_year']['product_name'],
      leastProductSalesYearCount: json['lease_sold_product_year']
          ['product_sales_count'],
      mostProductMonthName: json['most_sold_product_by_month']['product_name'],
      mostProductSalesMonthCount: json['most_sold_product_by_month']
          ['product_sales_count'],
      leastProductMonthName: json['least_sold_product_by_month']
          ['product_name'],
      leastProductSalesMonthCount: json['least_sold_product_by_month']
          ['product_sales_count'],
      mostProductQuarterName: json['most_sold_product_by_quarter']
          ['product_name'],
      mostProductSalesQuarterCount: json['most_sold_product_by_quarter']
          ['product_sales_count'],
      leastProductWeekName: json['least_sold_product_by_week']['product_name'],
      leastProductSalesWeekCount: json['least_sold_product_by_week']
          ['product_sales_count'],
      mostProductWeekName: json['most_sold_product_by_week']['product_name'],
      mostProductSalesWeekCount: json['most_sold_product_by_week']
          ['product_sales_count'],
    );
  }
}

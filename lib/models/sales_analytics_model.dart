class SalesAnalytics {
  String todaySales;
  int todaySalesCount;
  double todaySalesAmount;
  String monthSales;
  int monthSalesCount;
  double monthSalesAmount;
  String weekSales;
  int weekSalesCount;
  double weekSalesAmount;
  String quarterSales;
  int quarterSalesCount;
  double quarterSalesAmount;
  String yearSales;
  int yearSalesCount;
  double yearSalesAmount;

  SalesAnalytics(
      {this.todaySales,
      this.monthSales,
      this.quarterSales,
      this.todaySalesAmount,
      this.todaySalesCount,
      this.weekSales,
      this.yearSales,
      this.monthSalesAmount,
      this.monthSalesCount,
      this.quarterSalesAmount,
      this.quarterSalesCount,
      this.weekSalesAmount,
      this.weekSalesCount,
      this.yearSalesAmount,
      this.yearSalesCount});

  factory SalesAnalytics.fromJson(Map<String, dynamic> json) {
    return SalesAnalytics(
      todaySalesCount: json['today_sales']['total_sales_count'],
      todaySalesAmount: json['today_sales']['total_sales_amount'],
      monthSalesCount: json['month_sales']['total_sales_count'],
      monthSalesAmount: json['month_sales']['total_sales_amount'],
      weekSalesAmount: json['week_sales']['total_sales_amount'],
      weekSalesCount: json['week_sales']['total_sales_count'],
      quarterSalesAmount: json['quarter_sales']['total_sales_amount'],
      quarterSalesCount: json['quarter_sales']['total_sales_count'],
      yearSalesCount: json['year_sales']['total_sales_count'],
      yearSalesAmount: json['year_sales']['total_sales_amount'],
    );
  }
}

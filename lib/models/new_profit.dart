import 'dart:convert';

GrossProfit grossProfitFromJson(String str) =>
    GrossProfit.fromJson(json.decode(str));

String grossProfitToJson(GrossProfit data) => json.encode(data.toJson());

class GrossProfit {
  GrossProfit({
    this.grossProfit,
    this.retainedEarnings,
    this.profitAfterTax,
    this.netProfit,
  });

  GrossProfitClass grossProfit;
  double retainedEarnings;
  NetProfit profitAfterTax;
  NetProfit netProfit;

  factory GrossProfit.fromJson(Map<String, dynamic> json) => GrossProfit(
        grossProfit: GrossProfitClass.fromJson(json["gross_profit"]),
        retainedEarnings: json["retained_earnings"],
        profitAfterTax: NetProfit.fromJson(json["profit_after_tax"]),
        netProfit: NetProfit.fromJson(json["net_profit"]),
      );

  Map<String, dynamic> toJson() => {
        "gross_profit": grossProfit.toJson(),
        "retained_earnings": retainedEarnings,
        "profit_after_tax": profitAfterTax.toJson(),
        "net_profit": netProfit.toJson(),
      };
}

class GrossProfitClass {
  GrossProfitClass({
    this.today,
    this.month,
    this.week,
    this.quarter,
    this.year,
  });

  Month today;
  Month month;
  Month week;
  Month quarter;
  Month year;

  factory GrossProfitClass.fromJson(Map<String, dynamic> json) =>
      GrossProfitClass(
        today: Month.fromJson(json["today"]),
        month: Month.fromJson(json["month"]),
        week: Month.fromJson(json["week"]),
        quarter: Month.fromJson(json["quarter"]),
        year: Month.fromJson(json["year"]),
      );

  Map<String, dynamic> toJson() => {
        "today": today.toJson(),
        "month": month.toJson(),
        "week": week.toJson(),
        "quarter": quarter.toJson(),
        "year": year.toJson(),
      };
}

class Month {
  Month({
    this.totalAmount,
  });

  double totalAmount;

  factory Month.fromJson(Map<String, dynamic> json) => Month(
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "total_amount": totalAmount,
      };
}

class NetProfit {
  NetProfit({
    this.today,
    this.month,
    this.week,
    this.year,
  });

  double today;
  double month;
  double week;
  double year;

  factory NetProfit.fromJson(Map<String, dynamic> json) => NetProfit(
        today: json["today"],
        week: json["week"],
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "today": today,
        "week": week,
        "month": month,
        "year": year,
      };
}

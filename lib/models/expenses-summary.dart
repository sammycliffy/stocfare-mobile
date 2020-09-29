class ExpensesSummary {
  double todaySummary;
  double monthSummary;
  double weekSummary;
  double quarterSummary;
  double yearSummary;
  ExpensesSummary(
      {this.todaySummary,
      this.weekSummary,
      this.monthSummary,
      this.quarterSummary,
      this.yearSummary});
  factory ExpensesSummary.fromJson(Map<String, dynamic> json) {
    return ExpensesSummary(
      todaySummary: json['today']['total_amount'],
      weekSummary: json['week']['total_amount'],
      monthSummary: json['month']['total_amount'],
      quarterSummary: json['quarter']['total_amount'],
      yearSummary: json['year']['total_amount'],
    );
  }
}

class GetAllExpenses {
  String id;
  String expenseMadeOnName;
  String amount;
  String date;
  String note;

  GetAllExpenses(
      {this.id, this.expenseMadeOnName, this.amount, this.date, this.note});

  GetAllExpenses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseMadeOnName = json['expense_made_on_name'];
    amount = json['amount'];
    date = json['date'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_made_on_name'] = this.expenseMadeOnName;
    data['amount'] = this.amount;
    data['date'] = this.date;
    data['note'] = this.note;
    return data;
  }
}

class ProfitModel {
  String id;
  SalesProfitId salesProfitId;
  List<ProductInfo> productInfo;
  String date;
  String amount;

  ProfitModel(
      {this.id, this.salesProfitId, this.productInfo, this.date, this.amount});

  ProfitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesProfitId = json['sales_profit_id'] != null
        ? new SalesProfitId.fromJson(json['sales_profit_id'])
        : null;
    if (json['product_info'] != null) {
      productInfo = new List<ProductInfo>();
      json['product_info'].forEach((v) {
        productInfo.add(new ProductInfo.fromJson(v));
      });
    }
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.salesProfitId != null) {
      data['sales_profit_id'] = this.salesProfitId.toJson();
    }
    if (this.productInfo != null) {
      data['product_info'] = this.productInfo.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    data['amount'] = this.amount;
    return data;
  }
}

class SalesProfitId {
  String id;
  Customer customer;
  String saleRegisteredBy;
  String pdfFileLink;
  List<ProductDetail> productDetail;
  String amount;
  String change;
  String paymentMethod;
  bool soldOnCredit;
  String dateCreated;
  String tax;
  String amountPaid;
  String refCode;

  SalesProfitId(
      {this.id,
      this.customer,
      this.saleRegisteredBy,
      this.pdfFileLink,
      this.productDetail,
      this.amount,
      this.change,
      this.paymentMethod,
      this.soldOnCredit,
      this.dateCreated,
      this.tax,
      this.amountPaid,
      this.refCode});

  SalesProfitId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    saleRegisteredBy = json['sale_registered_by'];
    pdfFileLink = json['pdf_file_link'];
    if (json['product_detail'] != null) {
      productDetail = new List<ProductDetail>();
      json['product_detail'].forEach((v) {
        productDetail.add(new ProductDetail.fromJson(v));
      });
    }
    amount = json['amount'];
    change = json['change'];
    paymentMethod = json['payment_method'];
    soldOnCredit = json['sold_on_credit'];
    dateCreated = json['date_created'];
    tax = json['tax'];
    amountPaid = json['amount_paid'];
    refCode = json['ref_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    data['sale_registered_by'] = this.saleRegisteredBy;
    data['pdf_file_link'] = this.pdfFileLink;
    if (this.productDetail != null) {
      data['product_detail'] =
          this.productDetail.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['change'] = this.change;
    data['payment_method'] = this.paymentMethod;
    data['sold_on_credit'] = this.soldOnCredit;
    data['date_created'] = this.dateCreated;
    data['tax'] = this.tax;
    data['amount_paid'] = this.amountPaid;
    data['ref_code'] = this.refCode;
    return data;
  }
}

class Customer {
  String id;
  String name;
  String address;
  String mobile;
  Null email;
  String dateCreated;
  Null updatedAt;
  String firebaseId;

  Customer(
      {this.id,
      this.name,
      this.address,
      this.mobile,
      this.email,
      this.dateCreated,
      this.updatedAt,
      this.firebaseId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    mobile = json['mobile'];
    email = json['email'];
    dateCreated = json['date_created'];
    updatedAt = json['updated_at'];
    firebaseId = json['firebase_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['date_created'] = this.dateCreated;
    data['updated_at'] = this.updatedAt;
    data['firebase_id'] = this.firebaseId;
    return data;
  }
}

class ProductDetail {
  String name;
  int costPrice;
  int totalCost;
  int sellingPrice;
  int quantityBought;

  ProductDetail(
      {this.name,
      this.costPrice,
      this.totalCost,
      this.sellingPrice,
      this.quantityBought});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    costPrice = json['cost_price'];
    totalCost = json['total_cost'];
    sellingPrice = json['selling_price'];
    quantityBought = json['quantity_bought'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cost_price'] = this.costPrice;
    data['total_cost'] = this.totalCost;
    data['selling_price'] = this.sellingPrice;
    data['quantity_bought'] = this.quantityBought;
    return data;
  }
}

class ProductInfo {
  String name;
  String amount;
  int quantity;

  ProductInfo({this.name, this.amount, this.quantity});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    quantity = json['quantity:'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['quantity:'] = this.quantity;
    return data;
  }
}

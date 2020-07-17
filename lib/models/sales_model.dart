// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.customer,
    this.productData,
    this.saleRegisteredBy,
    this.productDetail,
    this.pdfFileLink,
    this.amount,
    this.change,
    this.paymentMethod,
    this.soldOnCredit,
    this.dateCreated,
    this.tax,
    this.amountPaid,
    this.refCode,
  });

  String id;
  Customer customer;
  List<ProductData> productData;
  String saleRegisteredBy;
  List<ProductDetail> productDetail;
  String pdfFileLink;
  String amount;
  String change;
  String paymentMethod;
  bool soldOnCredit;
  DateTime dateCreated;
  String tax;
  String amountPaid;
  String refCode;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        productData: List<ProductData>.from(
            json["product_data"].map((x) => ProductData.fromJson(x))),
        saleRegisteredBy: json["sale_registered_by"],
        productDetail: List<ProductDetail>.from(
            json["product_detail"].map((x) => ProductDetail.fromJson(x))),
        pdfFileLink: json["pdf_file_link"],
        amount: json["amount"],
        change: json["change"],
        paymentMethod: json["payment_method"],
        soldOnCredit: json["sold_on_credit"],
        dateCreated: DateTime.parse(json["date_created"]),
        tax: json["tax"],
        amountPaid: json["amount_paid"],
        refCode: json["ref_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer": customer == null ? null : customer.toJson(),
        "product_data": List<dynamic>.from(productData.map((x) => x.toJson())),
        "sale_registered_by": saleRegisteredBy,
        "product_detail":
            List<dynamic>.from(productDetail.map((x) => x.toJson())),
        "pdf_file_link": pdfFileLink,
        "amount": amount,
        "change": change,
        "payment_method": paymentMethod,
        "sold_on_credit": soldOnCredit,
        "date_created": dateCreated.toIso8601String(),
        "tax": tax,
        "amount_paid": amountPaid,
        "ref_code": refCode,
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.address,
    this.mobile,
    this.email,
    this.dateCreated,
    this.updatedAt,
  });

  String id;
  String name;
  dynamic address;
  String mobile;
  String email;
  DateTime dateCreated;
  DateTime updatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        mobile: json["mobile"],
        email: json["email"],
        dateCreated: DateTime.parse(json["date_created"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "mobile": mobile,
        "email": email,
        "date_created": dateCreated.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class ProductData {
  ProductData({
    this.id,
    this.productColour,
    this.productUnit,
    this.productPack,
    this.productImage,
    this.name,
    this.active,
    this.description,
    this.tax,
    this.weight,
    this.dateCreated,
    this.barCode,
    this.discount,
  });

  String id;
  List<ProductColour> productColour;
  Product productUnit;
  Product productPack;
  List<dynamic> productImage;
  String name;
  bool active;
  String description;
  String tax;
  String weight;
  DateTime dateCreated;
  String barCode;
  String discount;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        productColour: List<ProductColour>.from(
            json["product_colour"].map((x) => ProductColour.fromJson(x))),
        productUnit: Product.fromJson(json["product_unit"]),
        productPack: Product.fromJson(json["product_pack"]),
        productImage: List<dynamic>.from(json["product_image"].map((x) => x)),
        name: json["name"],
        active: json["active"],
        description: json["description"],
        tax: json["tax"],
        weight: json["weight"],
        dateCreated: DateTime.parse(json["date_created"]),
        barCode: json["bar_code"],
        discount: json["discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_colour":
            List<dynamic>.from(productColour.map((x) => x.toJson())),
        "product_unit": productUnit.toJson(),
        "product_pack": productPack.toJson(),
        "product_image": List<dynamic>.from(productImage.map((x) => x)),
        "name": name,
        "active": active,
        "description": description,
        "tax": tax,
        "weight": weight,
        "date_created": dateCreated.toIso8601String(),
        "bar_code": barCode,
        "discount": discount,
      };
}

class ProductColour {
  ProductColour({
    this.id,
    this.name,
    this.limit,
    this.quantity,
    this.active,
  });

  String id;
  String name;
  int limit;
  int quantity;
  bool active;

  factory ProductColour.fromJson(Map<String, dynamic> json) => ProductColour(
        id: json["id"],
        name: json["name"],
        limit: json["limit"],
        quantity: json["quantity"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "limit": limit,
        "quantity": quantity,
        "active": active,
      };
}

class Product {
  Product({
    this.id,
    this.price,
    this.limit,
    this.quantity,
    this.unit,
  });

  String id;
  int price;
  int limit;
  int quantity;
  int unit;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        limit: json["limit"],
        quantity: json["quantity"],
        unit: json["unit"] == null ? null : json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "limit": limit,
        "quantity": quantity,
        "unit": unit == null ? null : unit,
      };
}

class ProductDetail {
  ProductDetail({
    this.name,
    this.soldAs,
    this.totalCost,
    this.quantityBought,
  });

  String name;
  String soldAs;
  int totalCost;
  int quantityBought;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        name: json["name"],
        soldAs: json["sold_as"],
        totalCost: json["total_cost"],
        quantityBought: json["quantity_bought"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sold_as": soldAs,
        "total_cost": totalCost,
        "quantity_bought": quantityBought,
      };
}

// To parse this JSON data, do
//
//     final getSalesModel = getSalesModelFromJson(jsonString);

import 'dart:convert';

GetSalesModel getSalesModelFromJson(String str) =>
    GetSalesModel.fromJson(json.decode(str));

String getSalesModelToJson(GetSalesModel data) => json.encode(data.toJson());

class GetSalesModel {
  GetSalesModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory GetSalesModel.fromJson(Map<String, dynamic> json) => GetSalesModel(
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
  List<ProductDatum> productData;
  String saleRegisteredBy;
  List<ProductDetail> productDetail;
  String pdfFileLink;
  dynamic amount;
  dynamic change;
  String paymentMethod;
  bool soldOnCredit;
  DateTime dateCreated;
  dynamic tax;
  dynamic amountPaid;
  String refCode;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        productData: List<ProductDatum>.from(
            json["product_data"].map((x) => ProductDatum.fromJson(x))),
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
  String address;
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
        dateCreated: DateTime.parse(json["date_created"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "mobile": mobile,
        "email": email,
        "date_created": dateCreated.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ProductDatum {
  ProductDatum({
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
  List<dynamic> productColour;
  Product productUnit;
  Product productPack;
  List<ProductImage> productImage;
  String name;
  bool active;
  String description;
  dynamic tax;
  String weight;
  DateTime dateCreated;
  dynamic barCode;
  dynamic discount;

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json["id"],
        productColour: List<dynamic>.from(json["product_colour"].map((x) => x)),
        productUnit: Product.fromJson(json["product_unit"]),
        productPack: Product.fromJson(json["product_pack"]),
        productImage: List<ProductImage>.from(
            json["product_image"].map((x) => ProductImage.fromJson(x))),
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
        "product_colour": List<dynamic>.from(productColour.map((x) => x)),
        "product_unit": productUnit.toJson(),
        "product_pack": productPack.toJson(),
        "product_image":
            List<dynamic>.from(productImage.map((x) => x.toJson())),
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

class ProductImage {
  ProductImage({
    this.id,
    this.imageLink,
  });

  String id;
  String imageLink;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        imageLink: json["image_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_link": imageLink,
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
  dynamic price;
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
    this.totalCost,
    this.quantityBought,
  });

  String name;
  dynamic totalCost;
  int quantityBought;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        name: json["name"],
        totalCost: json["total_cost"],
        quantityBought: json["quantity_bought"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total_cost": totalCost,
        "quantity_bought": quantityBought,
      };
}

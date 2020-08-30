// To parse this JSON data, do
//
//     final createSalesModel = createSalesModelFromJson(jsonString);

import 'dart:convert';

CreateSalesModel createSalesModelFromJson(String str) =>
    CreateSalesModel.fromJson(json.decode(str));

String createSalesModelToJson(CreateSalesModel data) =>
    json.encode(data.toJson());

class CreateSalesModel {
  CreateSalesModel({
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
  dynamic customer;
  List<ProductDatum> productData;
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

  factory CreateSalesModel.fromJson(Map<String, dynamic> json) =>
      CreateSalesModel(
        id: json["id"],
        customer: json["customer"],
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
        "customer": customer,
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
  String discount;

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
    this.quantityBought,
    this.totalCost,
  });

  String name;
  int quantityBought;
  int totalCost;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        name: json["name"],
        quantityBought: json["quantity_bought"],
        totalCost: json["total_cost"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity_bought": quantityBought,
        "total_cost": totalCost,
      };
}

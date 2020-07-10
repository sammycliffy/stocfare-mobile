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
  dynamic next;
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
    this.name,
    this.productCount,
    this.firebaseId,
    this.products,
  });

  String id;
  String name;
  int productCount;
  String firebaseId;
  List<Product> products;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        productCount: json["product_count"],
        firebaseId: json["firebase_id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_count": productCount,
        "firebase_id": firebaseId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.productColour,
    this.productImage,
    this.productUnit,
    this.productPack,
    this.branchId,
    this.productCategoryId,
    this.image,
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
  List<ProductImage> productImage;
  ProductPackClass productUnit;
  ProductPackClass productPack;
  String branchId;
  String productCategoryId;
  dynamic image;
  String name;
  bool active;
  String description;
  String tax;
  String weight;
  DateTime dateCreated;
  String barCode;
  String discount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productColour: List<ProductColour>.from(
            json["product_colour"].map((x) => ProductColour.fromJson(x))),
        productImage: List<ProductImage>.from(
            json["product_image"].map((x) => ProductImage.fromJson(x))),
        productUnit: ProductPackClass.fromJson(json["product_unit"]),
        productPack: ProductPackClass.fromJson(json["product_pack"]),
        branchId: json["branch_id"],
        productCategoryId: json["product_category_id"],
        image: json["image"],
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
        "product_image":
            List<dynamic>.from(productImage.map((x) => x.toJson())),
        "product_unit": productUnit.toJson(),
        "product_pack": productPack.toJson(),
        "branch_id": branchId,
        "product_category_id": productCategoryId,
        "image": image,
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

class ProductPackClass {
  ProductPackClass({
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

  factory ProductPackClass.fromJson(Map<String, dynamic> json) =>
      ProductPackClass(
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

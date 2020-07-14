import 'package:firebase_database/firebase_database.dart';

class ProductList {
  ProductList({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ProductList.fromSnapshot(DataSnapshot snapshot)
      : count = snapshot.value['count'],
        results = List<Result>.from(
            snapshot.value['result'].map((x) => Result.fromSnapshot(x)));
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

  Result.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value["id"],
        name = snapshot.value["name"],
        productCount = snapshot.value["product_count"],
        firebaseId = snapshot.value["firebase_id"],
        products = List<Product>.from(
            snapshot.value["products"].map((x) => Product.fromSnapshot(x)));
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

  Product.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value["id"],
        productColour = List<ProductColour>.from(snapshot
            .value["product_colour"]
            .map((x) => ProductColour.fromSnapshot(x))),
        productImage = List<ProductImage>.from(snapshot.value["product_image"]
            .map((x) => ProductImage.fromSnapshot(x))),
        productUnit =
            ProductPackClass.fromSnapshot(snapshot.value["product_unit"]),
        productPack =
            ProductPackClass.fromSnapshot(snapshot.value["product_pack"]),
        branchId = snapshot.value["branch_id"],
        productCategoryId = snapshot.value["product_category_id"],
        image = snapshot.value["image"],
        name = snapshot.value["name"],
        active = snapshot.value["active"],
        description = snapshot.value["description"],
        tax = snapshot.value["tax"],
        weight = snapshot.value["weight"],
        dateCreated = DateTime.parse(snapshot.value["date_created"]),
        barCode = snapshot.value["bar_code"],
        discount = snapshot.value["discount"];
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

  ProductColour.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value["id"],
        name = snapshot.value["name"],
        limit = snapshot.value["limit"],
        quantity = snapshot.value["quantity"],
        active = snapshot.value["active"];
}

class ProductImage {
  ProductImage({
    this.id,
    this.imageLink,
  });

  String id;
  String imageLink;

  ProductImage.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value["id"],
        imageLink = snapshot.value["image_link"];
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

  ProductPackClass.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value["id"],
        price = snapshot.value["price"],
        limit = snapshot.value["limit"],
        quantity = snapshot.value["quantity"],
        unit = snapshot.value["unit"] == null ? null : snapshot.value["unit"];
}

class ProductList {
  int count;
  Null next;
  Null previous;
  List<Results> results;

  ProductList({this.count, this.next, this.previous, this.results});

  ProductList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String id;
  String name;
  int productCount;
  String firebaseId;
  List<Products> products;

  Results(
      {this.id, this.name, this.productCount, this.firebaseId, this.products});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productCount = json['product_count'];
    firebaseId = json['firebase_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['product_count'] = this.productCount;
    data['firebase_id'] = this.firebaseId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String id;
  List<ProductColour> productColour;
  List<ProductImage> productImage;
  ProductUnit productUnit;
  ProductPack productPack;
  String branchId;
  String productCategoryId;
  Null image;
  String name;
  bool active;
  String description;
  String tax;
  String weight;
  String dateCreated;
  String barCode;
  String discount;

  Products(
      {this.id,
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
      this.discount});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_colour'] != null) {
      productColour = new List<ProductColour>();
      json['product_colour'].forEach((v) {
        productColour.add(new ProductColour.fromJson(v));
      });
    }
    if (json['product_image'] != null) {
      productImage = new List<ProductImage>();
      json['product_image'].forEach((v) {
        productImage.add(new ProductImage.fromJson(v));
      });
    }
    productUnit = json['product_unit'] != null
        ? new ProductUnit.fromJson(json['product_unit'])
        : null;
    productPack = json['product_pack'] != null
        ? new ProductPack.fromJson(json['product_pack'])
        : null;
    branchId = json['branch_id'];
    productCategoryId = json['product_category_id'];
    image = json['image'];
    name = json['name'];
    active = json['active'];
    description = json['description'];
    tax = json['tax'];
    weight = json['weight'];
    dateCreated = json['date_created'];
    barCode = json['bar_code'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productColour != null) {
      data['product_colour'] =
          this.productColour.map((v) => v.toJson()).toList();
    }
    if (this.productImage != null) {
      data['product_image'] = this.productImage.map((v) => v.toJson()).toList();
    }
    if (this.productUnit != null) {
      data['product_unit'] = this.productUnit.toJson();
    }
    if (this.productPack != null) {
      data['product_pack'] = this.productPack.toJson();
    }
    data['branch_id'] = this.branchId;
    data['product_category_id'] = this.productCategoryId;
    data['image'] = this.image;
    data['name'] = this.name;
    data['active'] = this.active;
    data['description'] = this.description;
    data['tax'] = this.tax;
    data['weight'] = this.weight;
    data['date_created'] = this.dateCreated;
    data['bar_code'] = this.barCode;
    data['discount'] = this.discount;
    return data;
  }
}

class ProductColour {
  String id;
  String name;
  int limit;
  int quantity;
  bool active;

  ProductColour({this.id, this.name, this.limit, this.quantity, this.active});

  ProductColour.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    limit = json['limit'];
    quantity = json['quantity'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['limit'] = this.limit;
    data['quantity'] = this.quantity;
    data['active'] = this.active;
    return data;
  }
}

class ProductImage {
  String id;
  String imageLink;

  ProductImage({this.id, this.imageLink});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_link'] = this.imageLink;
    return data;
  }
}

class ProductUnit {
  String id;
  int price;
  int quantity;
  int limit;

  ProductUnit({this.id, this.price, this.quantity, this.limit});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['limit'] = this.limit;
    return data;
  }
}

class ProductPack {
  String id;
  int price;
  int limit;
  int quantity;
  int unit;

  ProductPack({this.id, this.price, this.limit, this.quantity, this.unit});

  ProductPack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    limit = json['limit'];
    quantity = json['quantity'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['limit'] = this.limit;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    return data;
  }
}

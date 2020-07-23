class FirebaseCustomer {
  FirebaseId firebaseId;

  FirebaseCustomer({this.firebaseId});

  FirebaseCustomer.fromJson(Map<String, dynamic> json, id) {
    firebaseId =
        json['$id'] != null ? new FirebaseId.fromJson(json['$id']) : null;
  }
}

class FirebaseId {
  MCNY7MIP7pazpzpT4bW mCNY7MIP7pazpzpT4bW;

  FirebaseId({this.mCNY7MIP7pazpzpT4bW});

  FirebaseId.fromJson(Map<String, dynamic> json) {
    mCNY7MIP7pazpzpT4bW = json['-MCNY7MIP7pazpzpT4bW'] != null
        ? new MCNY7MIP7pazpzpT4bW.fromJson(json['-MCNY7MIP7pazpzpT4bW'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mCNY7MIP7pazpzpT4bW != null) {
      data['-MCNY7MIP7pazpzpT4bW'] = this.mCNY7MIP7pazpzpT4bW.toJson();
    }
    return data;
  }
}

class MCNY7MIP7pazpzpT4bW {
  int productCount;
  String name;
  String id;
  List<Products> products;

  MCNY7MIP7pazpzpT4bW({this.productCount, this.name, this.id, this.products});

  MCNY7MIP7pazpzpT4bW.fromJson(Map<String, dynamic> json) {
    productCount = json['product_count'];
    name = json['name'];
    id = json['id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_count'] = this.productCount;
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String dateCreated;
  List<ProductImage> productImage;
  String name;
  bool active;
  String description;
  String id;
  ProductUnit productUnit;
  ProductPack productPack;

  Products(
      {this.dateCreated,
      this.productImage,
      this.name,
      this.active,
      this.description,
      this.id,
      this.productUnit,
      this.productPack});

  Products.fromJson(Map<String, dynamic> json) {
    dateCreated = json['date_created'];
    if (json['product_image'] != null) {
      productImage = new List<ProductImage>();
      json['product_image'].forEach((v) {
        productImage.add(new ProductImage.fromJson(v));
      });
    }
    name = json['name'];
    active = json['active'];
    description = json['description'];
    id = json['id'];
    productUnit = json['product_unit'] != null
        ? new ProductUnit.fromJson(json['product_unit'])
        : null;
    productPack = json['product_pack'] != null
        ? new ProductPack.fromJson(json['product_pack'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_created'] = this.dateCreated;
    if (this.productImage != null) {
      data['product_image'] = this.productImage.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['active'] = this.active;
    data['description'] = this.description;
    data['id'] = this.id;
    if (this.productUnit != null) {
      data['product_unit'] = this.productUnit.toJson();
    }
    if (this.productPack != null) {
      data['product_pack'] = this.productPack.toJson();
    }
    return data;
  }
}

class ProductImage {
  String imageLink;
  String id;

  ProductImage({this.imageLink, this.id});

  ProductImage.fromJson(Map<String, dynamic> json) {
    imageLink = json['image_link'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_link'] = this.imageLink;
    data['id'] = this.id;
    return data;
  }
}

class ProductUnit {
  int quantity;
  int price;
  int limit;
  String id;

  ProductUnit({this.quantity, this.price, this.limit, this.id});

  ProductUnit.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    price = json['price'];
    limit = json['limit'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['limit'] = this.limit;
    data['id'] = this.id;
    return data;
  }
}

class ProductPack {
  int unit;
  int quantity;
  int price;
  int limit;
  String id;

  ProductPack({this.unit, this.quantity, this.price, this.limit, this.id});

  ProductPack.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    quantity = json['quantity'];
    price = json['price'];
    limit = json['limit'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['limit'] = this.limit;
    data['id'] = this.id;
    return data;
  }
}

import 'package:sqlcool/sqlcool.dart';
import 'package:stockfare_mobile/models/db_model.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class DatabaseSchema {
  Db db = Db();

  static DbTable category = DbTable("category")
    ..varchar('category_id', unique: true)
    ..varchar("name", unique: true);
  static DbTable product = DbTable("product")
    ..integer('productId', unique: true, nullable: true)
    ..varchar('name', unique: true)
    ..varchar('description', nullable: true)
    ..varchar('product_unit_price', nullable: true)
    ..varchar('product_unit_quantity', nullable: true)
    ..varchar('product_unit_limit', nullable: true)
    ..varchar('product_pack_price', nullable: true)
    ..varchar('product_pack_quantity', nullable: true)
    ..varchar('product_pack_limit', nullable: true)
    ..varchar('image_link', nullable: true)
    ..integer('weight', nullable: true)
    ..varchar('date_created', nullable: true)
    ..varchar('bar_code', nullable: true)
    ..integer('discount', nullable: true)
    ..foreignKey("category", onDelete: OnDelete.cascade);
  String dbpath = "db.sqlite";
  List<DbTable> schema = [
    category,
    product,
  ];

  initDatabase() async {
    String dbpath = "db.sqlite"; // relative to the documents directory
    db.init(path: dbpath, schema: schema, verbose: true).catchError((e) {
      throw ("Error initializing the database: $e");
    });
    return db;
  }

  Future<Map<String, String>> insertDatabase() async {
    String dbpath = "db.sqlite"; // relative to the documents directory
    try {
      await db.init(path: dbpath, schema: schema);
    } catch (e) {
      rethrow;
    }
    try {
      ProductServices _productServices = ProductServices();
      _productServices.getAllProducts().then((value) {
        int index = -1;
        List categoryList = [];
        print(value.results.map((category) async {
          categoryList.add({'name': category.name, 'id': category.id});

          // final Map<String, String> row = {
          //   'category_id': category.id,
          //   'name': category.name
          // };
          // int id = await db.insert(table: "category", row: row);
          // print(category.name + index++).toString());
          index = index + 1;

          print(value.results[index].products.map((name) async {
            final Map<String, String> rows = {
              'category': categoryList[index].toString(),
              'name': name.name,
              'productId': name.id,
              'description': name.description,
              'weight': name.weight,
              'bar_code': name.barCode,
              'discount': name.discount,
              'date_created': name.dateCreated,
              'product_unit_price': name.productUnit.price.toString(),
              'product_unit_quantity': name.productUnit.quantity.toString(),
              'product_unit_limit': name.productUnit.limit.toString(),
              'product_pack_price': name.productPack.price.toString(),
              'product_pack_quantity': name.productPack.quantity.toString(),
              'product_pack_limit': name.productPack.limit.toString(),
              'image_link': name.productImage[0].imageLink
            };
            int id = await db.insert(table: "product", row: rows);
            return rows;
          }));
        }));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<DataModel> retrieveDatabase() async {
    String dbpath = "db.sqlite"; // relative to the documents directory
    db.init(path: dbpath, schema: schema, verbose: true).catchError((e) {
      throw ("Error initializing the database: $e");
    });
    return db.onReady.then((_) async {
      try {
        List<Map<String, dynamic>> rows = await db.select(
          table: "product",
          orderBy: "name",
        );
        return DataModel.fromJson(rows);
      } catch (e) {
        rethrow;
      }
    });
  }

  void deleteTable() async {
    String q1 = "DELETE FROM product";
    String q2 = "DROP TABLE category";
    List<String> queries = [q1, q2];
    String dbpath = "db.sqlite"; // relative to the documents directory
    db.init(path: dbpath, schema: schema, verbose: true).catchError((e) {
      throw ("Error initializing the database: $e");
    });
    return db.onReady.then((value) async {
      db.query(q1).catchError((e) {
        throw ("Error initializing the database: $e");
      });
    });
  }
}

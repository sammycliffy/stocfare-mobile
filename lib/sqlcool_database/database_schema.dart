import 'package:sqlcool/sqlcool.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class DatabaseSchema {
  void createDatabase() async {
    Db db = Db();

    DbTable category = DbTable('category')
      ..varchar('name', unique: true)
      ..integer('category_id');

    DbTable product = DbTable('product')
      ..varchar('name')
      ..varchar('description')
      ..integer('weight')
      ..timestamp('date_created')
      ..varchar('bar_code')
      ..integer('discount');

    DbTable productUnit = DbTable('product_unit')
      ..integer('price')
      ..integer('quantity')
      ..integer('limit');

    DbTable productPack = DbTable('product_pack')
      ..integer('price')
      ..integer('quantity')
      ..integer('limit');

    List<DbTable> schema = [category, product];
    String dbpath = "db.sqlite"; // relative to the documents directory
    try {
      await db.init(path: dbpath, schema: schema);
    } catch (e) {
      rethrow;
    }
  }

  // //display product name
  // print(products.results.map((title) {
  //   return title.products[0].name;
  // }));

  void insertDatabase() async {
    Db db = Db();

    try {
      ProductServices _productServices = ProductServices();
      _productServices.getAllProducts().then((value) {
        value.results.map((category) async {
          final Map<String, String> row = {'name': category.name};
          final Map<String, String> productRow = {
            'name': category.products[0].name
          };
          int id = await db.insert(table: "category", row: row);
          int name = await db.insert(table: "product", row: productRow);
        });
      });
    } catch (e) {
      rethrow;
    }
  }
}

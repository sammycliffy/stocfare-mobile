import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_products_category/add_form-page.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_products_category/upload_excel_product.dart';

class AddProductHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.directions_car),
                text: 'Add Single Product',
              ),
              Tab(
                icon: Icon(Icons.directions_transit),
                text: 'Add Multiple Products',
              ),
            ],
          ),
          title: Text('Add Products'),
        ),
        body: TabBarView(
          children: [
            AddFormPage(),
            UploadExcelProduct(),
          ],
        ),
      ),
    );
  }
}

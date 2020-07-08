import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/add_multiple_product/upload_excel.dart';
import 'package:stockfare_mobile/intro_pages/add_single_products/form.dart';

class AddProductPage extends StatelessWidget {
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
            FormPage(),
            UploadExcelPage(),
          ],
        ),
      ),
    );
  }
}

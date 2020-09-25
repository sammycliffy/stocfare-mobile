import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_products_category/add_form-page.dart';

import 'add_multiple_product/upload_excel.dart';

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
                text: 'Add Single Product',
              ),
              Tab(
                text: 'Add Multiple Products',
              ),
            ],
          ),
          title: Text('Add Products'),
        ),
        body: TabBarView(
          children: [
            AddFormPage(),
            UploadExcelPage(),
          ],
        ),
      ),
    );
  }
}

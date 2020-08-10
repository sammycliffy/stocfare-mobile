import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class UploadExcelPage extends StatefulWidget {
  @override
  _UploadExcelPageState createState() => _UploadExcelPageState();
}

class _UploadExcelPageState extends State<UploadExcelPage> {
  File toSend;
  ProductServices _productServices = ProductServices();
  Future _getFile() async {
    File file = await FilePicker.getFile();
    return file;
  }

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProductNotifier =
        Provider.of<AddProductNotifier>(context);
    return Column(children: [
      SizedBox(
        height: 25,
      ),
      Center(
          child: Text(
        'Upload Excel file',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      )),
      Center(
        child: Text(toSend.toString()),
      ),
      SizedBox(
        height: 30,
      ),
      GestureDetector(
          child: Center(
              child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: toSend == null
                      ? Icon(Icons.file_upload, size: 70, color: Colors.green)
                      : Icon(Icons.file_download,
                          size: 70, color: Colors.green))),
          onTap: () {
            _getFile().then((value) {
              setState(() {
                toSend = value;
              });
            });
          }),
      SizedBox(
        height: 50,
      ),
      GestureDetector(
          child: Center(
            child: Container(
              height: 40,
              width: 180,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 3),
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Text(
                'Upload',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),
            ),
          ),
          onTap: () {
            _productServices
                .productFileUpload(_addProductNotifier.categoryId, toSend)
                .then((value) => print(value));
          }),
    ]);
  }
}

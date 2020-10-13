import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/helpers/sub_helpers.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/product_services.dart';
import 'package:path_provider/path_provider.dart';

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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _error;

  @override
  Widget build(BuildContext context) {
    AddProductNotifier _addProductNotifier =
        Provider.of<AddProductNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(children: [
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
          height: 30,
        ),
        InkWell(
          child: Text(
            'Download Excel Sample',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          onTap: () {
            downloadExcelSample();
          },
        ),
        SizedBox(
          height: 30,
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
              Subscription().getSubscriptionPlan().then((value) {
                if (value == 'PREMIUM') {
                  if (toSend == null) {
                    setState(() {
                      _error = 'You must select a file first';
                      _displaySnackBar(context);
                    });
                  } else {
                    DialogBoxes().loading(context);
                    _productServices
                        .productFileUpload(
                            _addProductNotifier.categoryId, toSend)
                        .then((value) {
                      if (value != 201 || value != 200) {
                        Navigator.pop(context);
                        setState(() {
                          _error = value;
                          _displaySnackBar(context);
                        });
                      } else {
                        Navigator.pop(context);
                        DialogBoxes().success(context);
                      }
                    });
                  }
                } else {
                  DialogBoxes().invalidSubscription(context);
                }
              });
            }),
      ]),
    );
  }

  downloadExcelSample() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final taskId = await FlutterDownloader.enqueue(
      url:
          'https://drive.google.com/uc?export=download&id=1n77fjmwOoOA4GrimMdfSJyvgtX9ksUsY',
      savedDir: appDocPath,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

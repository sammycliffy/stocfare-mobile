import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/helpers/sub_helpers.dart';
import 'package:stockfare_mobile/notifiers/product_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/product_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class UploadExcelPage extends StatefulWidget {
  @override
  _UploadExcelPageState createState() => _UploadExcelPageState();
}

class _UploadExcelPageState extends State<UploadExcelPage> {
  File toSend;
  ProductServices _productServices = ProductServices();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String _progress = "-";
  final String _fileUrl =
      "https://drive.google.com/uc?export=download&id=1n77fjmwOoOA4GrimMdfSJyvgtX9ksUsY";
  final String _fileName = "stockfare_excel_format.xlsx";

  Future _getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
      return file;
    }
  }

  Future<void> _download() async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, _fileName);
      await _startDownload(savePath);
    } else {
      // handle the scenario when user declines the permissions
    }
  }

  final Dio _dio = Dio();

  Future<void> _startDownload(String savePath) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(_fileUrl, savePath,
          onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      await _showNotification(result);
    }
  }

  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
        priority: Priority.High, importance: Importance.Max);
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android, iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess
            ? 'File downloaded successfully! Check Downloads folder'
            : 'There was an error while downloading the file.',
        platform,
        payload: json);
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      Directory appDocDir = await getTemporaryDirectory();
      return appDocDir;
    }
    return await getApplicationDocumentsDirectory();
  }

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: _onSelectNotification);
  }

  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
    return permission == PermissionStatus.granted;
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
        Text(
          '$_progress',
          style: Theme.of(context).textTheme.display1,
        ),
        InkWell(
          child: Text(
            'Download Excel Sample',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          onTap: () {
            _download();
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
                      print(value);
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

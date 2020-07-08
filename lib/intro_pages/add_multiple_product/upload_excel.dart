import 'package:flutter/material.dart';

class UploadExcelPage extends StatefulWidget {
  @override
  _UploadExcelPageState createState() => _UploadExcelPageState();
}

class _UploadExcelPageState extends State<UploadExcelPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 25,
      ),
      Center(
          child: Text(
        'Upload Excel file',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      )),
      SizedBox(
        height: 30,
      ),
      Center(
          child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Icon(Icons.file_upload, size: 70, color: Colors.green))),
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
          onTap: () {}),
    ]);
  }
}

import 'package:flutter/material.dart';

class UploadExcelProduct extends StatefulWidget {
  @override
  _UploadExcelProductState createState() => _UploadExcelProductState();
}

class _UploadExcelProductState extends State<UploadExcelProduct> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 200, top: 20, bottom: 20),
        child: Container(
          width: 140,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.green),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Download Excel',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Icon(Icons.arrow_downward, color: Colors.white)
              ],
            ),
          ),
        ),
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

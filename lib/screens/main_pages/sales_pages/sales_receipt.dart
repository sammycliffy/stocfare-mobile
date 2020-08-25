import 'package:flutter/material.dart';

class SalesReceipt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Receipt'),
        actions: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: null,
                    color: Colors.white,
                  ),
                  Text('Share'),
                ],
              ),
            ),
            onTap: () {
              // _shareDocument();
            },
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.print),
                      onPressed: () {
                        // _printDocument(_signupNotifier);
                      },
                      color: Colors.white),
                  Text('Print'),
                ],
              ),
            ),
            onTap: () {
              // _printDocument(_signupNotifier);
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              Image.asset('assets/images/logo.png', width: 50, height: 50),
              Text(
                'Stockfare',
                style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 100),
              SpinKitCubeGrid(
                color: Colors.red[700],
                size: 50,
              ),
              SizedBox(height: 20),
              Text('Your business just got smarter.',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold))
            ],
          )),
    );
  }
}

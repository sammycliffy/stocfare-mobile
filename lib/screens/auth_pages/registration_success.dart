import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/auth_pages/phone_verification.dart';
import 'package:stockfare_mobile/screens/drawer_pages/logout.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/addProducts.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/add_single_products/form.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';

class SuccessRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => PhoneVerification())),
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(child: Icon(Icons.check, size: 80)),
              ),
              Text('Congratulations!!!',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor)),
              Text(
                'Your business just got smarter.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                  child: Center(
                    child: Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogoutPage()));
                  })
            ],
          )),
    );
  }
}

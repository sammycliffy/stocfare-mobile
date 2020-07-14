import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/drawer_pages/settings/change_password.dart';
import 'package:stockfare_mobile/screens/drawer_pages/settings/update_account.dart';
import 'package:stockfare_mobile/screens/drawer_pages/settings/update_current_brach.dart';

class SettingsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: <Widget>[
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 350,
                height: 50,
                color: Colors.grey[200],
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.person_add,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('UPDATE ACCOUNT DATA', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateAccount()));
            },
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 350,
                height: 50,
                color: Colors.grey[200],
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.update,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('UPDATE CURRENT BRANCH',
                        style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CurrentBranch()));
            },
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 350,
                height: 50,
                color: Colors.grey[200],
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('CHANGE PASSWORD', style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordPage()));
            },
          )
        ],
      ),
    );
  }
}

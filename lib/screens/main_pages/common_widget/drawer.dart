import "package:flutter/material.dart";
import 'package:stockfare_mobile/screens/drawer_pages/feedback.dart';
import 'package:stockfare_mobile/screens/drawer_pages/help.dart';
import 'package:stockfare_mobile/screens/drawer_pages/logout.dart';
import 'package:stockfare_mobile/screens/drawer_pages/settings/settings_home.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/list_of_workers.dart';
import 'package:stockfare_mobile/screens/subscription/sub_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    deleteSharedValue() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove('token');
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'stockfare_mobile',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Manage Subscription'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubscriptionPage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Workers'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WorkersListPage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsHomePage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HelpPage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              deleteSharedValue();
              Navigator.pop(context, true);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LogoutPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feed back'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FeedBackPage()))
            },
          ),
        ],
      ),
    );
  }
}

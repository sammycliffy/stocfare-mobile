import "package:flutter/material.dart";
import 'package:stockfare_mobile/drawer_pages/workers.dart';
import 'package:stockfare_mobile/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/subscription/starter.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/inventory.png'))),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Dashboard'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationPage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Online Store'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Manage Subscription'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StarterPage()))
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Workers'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddWorkers()))
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Settings'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddWorkers()))
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Help'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feed back'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/activities_model.dart';
import 'package:stockfare_mobile/services/activities_services.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  ActivitiesServices _activitiesServices = ActivitiesServices();
  Future<ActivitiesModel> _activitiesList;
  DateTime today = new DateTime.now();

  @override
  void initState() {
    super.initState();
    _activitiesList = _activitiesServices.getAllActivities();
    // _activitiesList.then((value) => print(value.activities.map((details) {
    //       print(details.description);
    //     })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Recent Activities')),
        backgroundColor: Colors.white,
        body: FutureBuilder<ActivitiesModel>(
          future: _activitiesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                  children: snapshot.data.activities.map((details) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.access_alarm),
                    title: Text(
                      details.description,
                      style: TextStyle(
                          fontFamily: 'FireSans',
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text(
                          details.dateCreated,
                          style: TextStyle(
                            fontFamily: 'FireSans',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          details.activityBy,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  ),
                );
              }).toList());
            } else {
              return Text('No data');
            }
          },
        ));
  }
}

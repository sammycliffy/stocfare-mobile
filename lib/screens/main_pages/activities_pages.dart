import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/activities_model.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:jiffy/jiffy.dart';

class ActivitiesPage extends StatefulWidget {
  @override
  _ActivitiesPageState createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  ActivitiesServices _activitiesServices = ActivitiesServices();
  Future<ActivitiesModel> _activitiesList;
  DateTime today = new DateTime.now();
  bool isNetwork = true;
  bool _error = false;
  String _errorData;

  @override
  void initState() {
    super.initState();
    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
        _activitiesList =
            _activitiesServices.getAllActivities().catchError((e) {
          setState(() {
            _error = true;
            _errorData = e.toString();
          });
        });
      } else {
        setState(() {
          isNetwork = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Recent Activities')),
        backgroundColor: Colors.white,
        body: (() {
          if (isNetwork == false) {
            return GestureDetector(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    Icon(
                      Icons.mood_bad,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'An error occured tap to refresth',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));
              },
            );
          } else if (_error == true) {
            return Center(
              child: Text(
                _errorData,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return FutureBuilder<ActivitiesModel>(
              future: _activitiesServices.getAllActivities(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                      children: snapshot.data.activities.map((details) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.arrow_forward),
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
                              Jiffy(details.dateCreated)
                                  .format("yyyy-MM-dd HH:mm:ss"),
                              style: TextStyle(
                                fontFamily: 'FireSans',
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              details.activityBy,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList());
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          }
        }()));
  }
}

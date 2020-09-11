import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/workers_models.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/add_workers.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/edit_workers.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/workers_services.dart';

class WorkersListPage extends StatefulWidget {
  @override
  _WorkersListPageState createState() => _WorkersListPageState();
}

class _WorkersListPageState extends State<WorkersListPage> {
  WorkersServices _workersServices = WorkersServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ActivitiesServices _activitiesServices = ActivitiesServices();
  bool isNetwork = true;
  dynamic result;
  bool _error = false;
  String _errorData;
  String _errorMessage;
  Future<WorkersList> _workersList;
  List<String> _workersName = [];
  List<String> _branchName = [];
  List<String> _phoneNumber = [];
  List<String> _id = [];
  @override
  void initState() {
    super.initState();
    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
        _workersList = _workersServices.getListOfWorkers().catchError((e) {
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
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    print(_signupNotifier.subscriptionPlan);
    print(_error);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Workers'),
      ),
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
                      'An error occured tap to refresh',
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
          return FutureBuilder<WorkersList>(
              future: _workersServices.getListOfWorkers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _workersName.clear();
                  _branchName.clear();
                  _phoneNumber.clear();
                  print(snapshot.data.results?.map((value) {
                    _workersName.add(value.fullName);
                    _branchName.add(value.branchName);
                    _phoneNumber.add(value.phoneNumber);
                    _id.add(value.id);
                  }));
                  if (snapshot.data.count != 0) {
                    return ListView.builder(
                        itemCount: _workersName.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              child: Card(
                                  child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              _workersName[index],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Branch Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(
                                      _branchName[index],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Phone Number',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    Text(_phoneNumber[index])
                                  ],
                                )
                              ],
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _confirmDelete(
                                    context,
                                    index,
                                  );
                                }),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditWorkersPage(
                                            workerIndex: index,
                                          )));
                            },
                          )));
                        });
                  } else {
                    return Center(
                      child: Text(
                        'You have not added any worker yet. \n Click on the button below to add.',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              });
        }
      }()),
      floatingActionButton: (() {
        if (_error) {
          return Visibility(
            child: FloatingActionButton(
              focusColor: Theme.of(context).canvasColor,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddWorkers()));
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            visible: false,
          );
        } else {
          return FloatingActionButton(
            focusColor: Theme.of(context).canvasColor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddWorkers()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          );
        }
      }()),
    );
  }

  Future<void> _confirmDelete(
    context,
    index,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Confirm Delete',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Are you sure you want to delete this worker?',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          )),
          actions: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                    child: Center(
                        child: Text(
                      'No',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    )),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    child: Center(
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      DialogBoxes().loading(context);
                      dynamic result = await _workersServices
                          .deleteWorker(_id[index])
                          .timeout(Duration(seconds: 10),
                              onTimeout: () => null);
                      if (result != 204) {
                        Navigator.pop(context);
                        setState(() {
                          result == null
                              ? _errorMessage =
                                  'Opps! Error occured, please try again.'
                              : _errorMessage = result.toString();
                          _displaySnackBar(context);
                        });
                      } else {
                        Navigator.pop(_scaffoldKey.currentContext);
                        setState(() {
                          _workersName.clear();
                          _branchName.clear();
                          _phoneNumber.clear();
                          _id.clear();
                          _workersList = _workersServices.getListOfWorkers();
                          _workersList.then((value) {
                            print(value.results.map((value) {
                              _workersName.add(value.fullName);
                              _branchName.add(value.branchName);
                              _phoneNumber.add(value.phoneNumber);
                              _id.add(value.id);
                            }));
                          });
                        });
                      }
                    }),
              ],
            )
          ],
        );
      },
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _errorMessage,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

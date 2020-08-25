import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockfare_mobile/models/workers_models.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/add_workers.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/edit_workers.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/workers_services.dart';

class WorkersListPage extends StatefulWidget {
  @override
  _WorkersListPageState createState() => _WorkersListPageState();
}

class _WorkersListPageState extends State<WorkersListPage> {
  WorkersServices _workersServices = WorkersServices();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String subscriptionPlan;
  Future<WorkersList> _workersList;
  List<String> _workersName = [];
  List<String> _branchName = [];
  List<String> _phoneNumber = [];
  List<String> _id = [];
  @override
  void initState() {
    super.initState();
    checkForPlan().then((value) {
      setState(() {
        subscriptionPlan =
            value; // assigns the value of the plan to subscription plan
      });
    });
    _workersList = _workersServices.getListOfWorkers();
    _workersList.then((value) {
      print(value.results.map((value) {
        _workersName.add(value.fullName);
        _branchName.add(value.branchName);
        _phoneNumber.add(value.phoneNumber);
        _id.add(value.id);
      }));
    });
  }

  //checks the plan of the user to determine whether it is premium or free
  Future<String> checkForPlan() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String subscriptionPlan = sharedPreferences.getString('subscription_plan');
    return subscriptionPlan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Workers'),
      ),
      body: subscriptionPlan == 'PREMIUM'
          ? FutureBuilder<WorkersList>(
              future: _workersList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data.count == 0) {
                      return Center(
                        child: Text(
                          'You have not added any worker yet. \n Click on the button below to add.',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }

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
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                }
                return Center(child: CircularProgressIndicator());
              })
          : Center(
              child: Text(
                  'You can only add workers when you are on Premium Plan',
                  style: TextStyle(fontSize: 18)),
            ),
      floatingActionButton: FloatingActionButton(
        focusColor: Theme.of(context).canvasColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddWorkers()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
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
                    onTap: () {
                      Navigator.pop(context);
                      DialogBoxes().loading(context);
                      _workersServices.deleteWorker(_id[index]).then((value) {
                        if (value == 204) {
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
                      });
                    }),
              ],
            )
          ],
        );
      },
    );
  }
}

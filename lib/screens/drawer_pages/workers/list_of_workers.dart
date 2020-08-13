import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/workers_models.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/add_workers.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/edit_workers.dart';
import 'package:stockfare_mobile/services/workers_services.dart';

class WorkersListPage extends StatefulWidget {
  @override
  _WorkersListPageState createState() => _WorkersListPageState();
}

class _WorkersListPageState extends State<WorkersListPage> {
  WorkersServices _workersServices = WorkersServices();
  Future<WorkersList> _workersList;
  List<String> _workersName = [];
  List<String> _branchName = [];
  List<String> _phoneNumber = [];
  @override
  void initState() {
    super.initState();
    _workersList = _workersServices.getListOfWorkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
      ),
      body: FutureBuilder<WorkersList>(
          future: _workersList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.count == 0) {
                return Center(
                  child: Text(
                      'You have not added any worker yet. \n Click on the button to add.'),
                );
              }
              print(snapshot.data.results.map((value) {
                _workersName.add(value.fullName);
                _branchName.add(value.branchName);
                _phoneNumber.add(value.phoneNumber);
              }));
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
                                Text('Branch Name'),
                                Container(
                                    width: 100,
                                    color: Colors.grey[300],
                                    child: Center(
                                        child: Text(
                                      _branchName[index],
                                    ))),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              children: <Widget>[
                                Text('Phone Number'),
                                Text(_phoneNumber[index])
                              ],
                            )
                          ],
                        ),
                        trailing: Container(
                          width: 20,
                          height: 25,
                          child: Center(
                            child: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[200]),
                        ),
                      )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditWorkersPage(
                                      workerIndex: index,
                                    )));
                      },
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
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
}

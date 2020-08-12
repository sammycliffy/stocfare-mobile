import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/workers_models.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/add_workers.dart';
import 'package:stockfare_mobile/services/workers_services.dart';

class WorkersListPage extends StatefulWidget {
  @override
  _WorkersListPageState createState() => _WorkersListPageState();
}

class _WorkersListPageState extends State<WorkersListPage> {
  WorkersServices _workersServices = WorkersServices();
  Future<WorkersList> _workersList;
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
              return Center(child: Text('yes'));
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

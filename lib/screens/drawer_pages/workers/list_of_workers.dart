import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/drawer_pages/workers/add_workers.dart';
import 'package:stockfare_mobile/services/workers_services.dart';

class WorkersListPage extends StatefulWidget {
  @override
  _WorkersListPageState createState() => _WorkersListPageState();
}

class _WorkersListPageState extends State<WorkersListPage> {
  WorkersServices _workersServices = WorkersServices();

  @override
  void initState() {
    super.initState();
    _workersServices.getListOfWorkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workers'),
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
}

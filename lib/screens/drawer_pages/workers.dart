import 'package:flutter/material.dart';

class AddWorkers extends StatefulWidget {
  @override
  _AddWorkersState createState() => _AddWorkersState();
}

class _AddWorkersState extends State<AddWorkers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            'Add Workers',
            style: TextStyle(fontSize: 15),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Fullname'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Phone Number'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: 'Password'),
                  )
                ],
              )),
            ),
            Text(
              'What will the worker do?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            _checkbox('CREATE WORKER', 'EDIT WORKER'),
            _checkbox('DELETE WORKER', 'EDIT CREATE SALES'),
            _checkbox('LIST SALES', 'EDIT SALES'),
            _checkbox('CREATE CATEGORY', 'LIST CATEGORY'),
            _checkbox('EDIT CATEGORY', 'DEACTIVATE CATEGORY'),
            _checkbox('ADD PRODUCT', 'EDIT PRODUCT'),
            _checkbox('LIST PRODUCT', 'DEACTIVATE PRODUCT'),
            _checkbox('VIEW ACTIVITIES', 'VIEW ANALYTICS')
          ],
        ),
      ),
    );
  }
}

Widget _checkbox(String text, String text1) {
  return Row(children: [
    Expanded(
      child: CheckboxListTile(
        title: Text(text),
        value: true,
        onChanged: (newValue) {},
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    ),
    Expanded(
      child: CheckboxListTile(
        title: Text(text1),
        value: true,
        onChanged: (newValue) {},
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    )
  ]);
}

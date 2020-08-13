import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/services/workers_services.dart';

class EditWorkersPage extends StatefulWidget {
  final int workerIndex;
  EditWorkersPage({Key key, @required this.workerIndex}) : super(key: key);

  @override
  _EditWorkersPageState createState() => _EditWorkersPageState();
}

class _EditWorkersPageState extends State<EditWorkersPage> {
  WorkersServices _workersServices = WorkersServices();
  String firstName;
  String lastName;
  String phoneNumber;
  String password;
  String emailAddress;
  bool _createWorker = false;
  bool _editWorker = false;
  bool _deleteWorker = false;
  bool _createSales = false;
  bool _listSales = false;
  bool _editSales = false;
  bool _createCategory = false;
  bool _listCategory = false;
  bool _editCategory = false;
  bool _deactivateCategory = false;
  bool _addProduct = false;
  bool _editProduct = false;
  bool _listProduct = false;
  bool _deactivateProduct = false;
  bool _viewActivities = false;
  bool _viewAnalytics = false;

  String _error;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> roles = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
        'Add Workers',
        style: TextStyle(fontSize: 15),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? 'Enter FirstName' : null,
                          onChanged: (val) => setState(() {
                            firstName = val;
                          }),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.person,
                                color: Theme.of(context).accentColor),
                            hintText: 'Enter your FirstName',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? 'Enter LastName' : null,
                          onChanged: (val) => setState(() {
                            lastName = val;
                          }),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.person,
                                color: Theme.of(context).accentColor),
                            hintText: 'Enter your LastName',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          style: TextStyle(color: Colors.black),
                          keyboardType: TextInputType.number,
                          validator: (input) =>
                              input.length < 10 ? 'Enter a valid phone' : null,
                          onChanged: (val) => setState(() {
                            phoneNumber = '+234' + val.substring(1);
                          }),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.phone_android,
                                color: Theme.of(context).accentColor),
                            hintText: 'Enter your phone number',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => !input.contains('@')
                              ? 'Enter a valid email address'
                              : null,
                          onChanged: (val) => setState(() {
                            emailAddress = val;
                          }),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(
                                color: Theme.of(context).primaryColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Theme.of(context).accentColor),
                            hintText: 'Email Address',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (input) => input.length < 6
                              ? 'Password must be > 6 Chars'
                              : null,
                          onChanged: (val) => setState(() {
                            password = val;
                          }),
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            prefixIcon: Icon(Icons.lock,
                                color: Theme.of(context).accentColor),
                            hintText: 'Password',
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.5))),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 40,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  'This worker should be able to:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'CREATE WORKER',
                    ),
                    value: _createWorker,
                    onChanged: (newValue) {
                      setState(() {
                        _createWorker = newValue;
                        roles.contains('CREATE_WORKER')
                            ? roles.remove('CREATE_WORKER')
                            : roles.add('CREATE_WORKER');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'EDIT WORKER',
                    ),
                    value: _editWorker,
                    onChanged: (newValue) {
                      setState(() {
                        _editWorker = newValue;
                        roles.contains('EDIT_WORKER')
                            ? roles.remove('EDIT_WORKER')
                            : roles.add('EDIT_WORKER');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'DELETE WORKER',
                    ),
                    value: _deleteWorker,
                    onChanged: (newValue) {
                      setState(() {
                        _deleteWorker = newValue;
                        roles.contains('DELETE_WORKER')
                            ? roles.remove('DELETE_WORKER')
                            : roles.add('DELETE_WORKER');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'CREATE SALES',
                    ),
                    value: _createSales,
                    onChanged: (newValue) {
                      setState(() {
                        _createSales = newValue;
                        roles.contains('CREATE_SALE')
                            ? roles.remove('CREATE_SALE')
                            : roles.add('CREATE_SALE');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'LIST SALES',
                    ),
                    value: _listSales,
                    onChanged: (newValue) {
                      setState(() {
                        _listSales = newValue;
                        roles.contains('LIST_SALE')
                            ? roles.remove('LIST_SALE')
                            : roles.add('LIST_SALE');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'EDIT SALE',
                    ),
                    value: _editSales,
                    onChanged: (newValue) {
                      setState(() {
                        _editSales = newValue;
                        roles.contains('EDIT_SALE')
                            ? roles.remove('EDIT_SALE')
                            : roles.add('EDIT_SALE');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'CREATE CATEGORY',
                    ),
                    value: _createCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _createCategory = newValue;
                        roles.contains('CREATE_CATEGORY')
                            ? roles.remove('CREATE_CATEGORY')
                            : roles.add('CREATE_CATEGORY');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'LIST CATEGORY',
                    ),
                    value: _listCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _listCategory = newValue;
                        roles.contains('LIST_CATEGORY')
                            ? roles.remove('LIST_CATEGORY')
                            : roles.add('LIST_CATEGORY');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'EDIT CATEGORY',
                    ),
                    value: _editCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _editCategory = newValue;
                        roles.contains('EDIT_CATEGORY')
                            ? roles.remove('EDIT_CATEGORY')
                            : roles.add('EDIT_CATEGORY');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'DEACTIVATE CATEGORY',
                    ),
                    value: _deactivateCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _deactivateCategory = newValue;
                        roles.contains('DEACTIVATE_CATEGORY')
                            ? roles.remove('DEACTIVATE_CATEGORY')
                            : roles.add('DEACTIVATE_CATEGORY');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'ADD PRODUCT',
                    ),
                    value: _addProduct,
                    onChanged: (newValue) {
                      setState(() {
                        _addProduct = newValue;
                        roles.contains('ADD_PRODUCT')
                            ? roles.remove('ADD_PRODUCT')
                            : roles.add('ADD_PRODUCT');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'EDIT PRODUCT',
                    ),
                    value: _editProduct,
                    onChanged: (newValue) {
                      setState(() {
                        _editProduct = newValue;
                        roles.contains('EDIT_PRODUCT')
                            ? roles.remove('EDIT_PRODUCT')
                            : roles.add('EDIT_PRODUCT');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'LIST PRODUCT',
                    ),
                    value: _listProduct,
                    onChanged: (newValue) {
                      setState(() {
                        _listProduct = newValue;
                        roles.contains('LIST_PRODUCT')
                            ? roles.remove('LIST_PRODUCT')
                            : roles.add('LIST_PRODUCT');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'DEACTIVATE PRODUCT',
                    ),
                    value: _deactivateProduct,
                    onChanged: (newValue) {
                      setState(() {
                        _deactivateProduct = newValue;
                        roles.contains('DEACTIVATE_PRODUCT')
                            ? roles.remove('DEACTIVATE_PRODUCT')
                            : roles.add('DEACTIVATE_PRODUCT');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'VIEW ACTIVITIES',
                    ),
                    value: _viewActivities,
                    onChanged: (newValue) {
                      setState(() {
                        _viewActivities = newValue;
                        roles.contains('VIEW_ACTIVITIES')
                            ? roles.remove('VIEW_ACTIVITIES')
                            : roles.add('VIEW_ACTIVITIES');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).primaryColor,
                    title: Text(
                      'VIEW ANALYTICS',
                    ),
                    value: _viewAnalytics,
                    onChanged: (newValue) {
                      setState(() {
                        _viewAnalytics = newValue;
                        roles.contains('')
                            ? roles.remove('VIEW_ANALYTICS')
                            : roles.add('VIEW_ANALYTICS');
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    DialogBoxes().loading(context);
                    _workersServices
                        .addWorkers(firstName, lastName, phoneNumber,
                            emailAddress, password, roles)
                        .then((value) {
                      if (value != 201) {
                        Navigator.pop(context);
                        setState(() {
                          _error = value.toString();
                          _displaySnackBar(context);
                        });
                      }
                      Navigator.pop(context);
                      DialogBoxes().success(context);
                    });
                  }
                }),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

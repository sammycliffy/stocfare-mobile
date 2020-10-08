import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class CustomersPage extends StatefulWidget {
  @override
  _CustomersPageState createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  ProductServices _productServices = ProductServices();
  List<String> _customerNames = [];
  List<String> _customerAddress = [];
  List<String> _phoneNumber = [];
  List<String> _customerEmail = [];
  List<String> _customerId = [];

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    final dbRef = FirebaseDatabase.instance; //firebase database reference
    dbRef.setPersistenceEnabled(true);
    dbRef.setPersistenceCacheSizeBytes(10000000);
    final databaseInstance = dbRef.reference();
    databaseInstance.keepSynced(true);
    final firebaseDb = databaseInstance
        .reference()
        .child('customer')
        .orderByKey()
        .equalTo(_signupNotifier.firebaseCustomerId);

    return Scaffold(
      appBar: AppBar(title: Text('Customers')),
      body: Column(
        children: [
          StreamBuilder(
              stream: firebaseDb.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.snapshot.value != null) {
                    _clear();
                    DataSnapshot dataValues = snapshot.data.snapshot;
                    var data = dataValues
                        .value['${_signupNotifier.firebaseCustomerId}'];
                    if (data is String) {
                      print('yes');
                    } else {
                      Map<dynamic, dynamic> values = dataValues
                          .value['${_signupNotifier.firebaseCustomerId}'];
                      print(values);
                      values?.forEach((key, values) {
                        _customerAddress.add(values['address']);
                        _phoneNumber.add(values['mobile']);
                        _customerNames.add(values['name']);
                        _customerId.add(values['id']);
                        _customerEmail.add(values['email']);
                      });
                      return ListView.separated(
                          shrinkWrap: true,
                          itemCount: _customerNames.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: ListTile(
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(300)),
                                  child: Center(
                                      child: Text(_customerNames[index][0],
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Theme.of(context)
                                                  .primaryColor))),
                                ),
                                title: Text(_customerNames[index],
                                    style: TextStyle(fontSize: 19)),
                                subtitle: Text(_phoneNumber[index]),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                              onTap: () {
                                _customerDetails(context, index);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider());
                    }
                  }
                  return Center(
                    child: Text('No Customer yet'),
                  );
                }
                return Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }

  _clear() {
    _customerNames.clear();
    _customerAddress.clear();
    _phoneNumber.clear();
    _customerEmail.clear();
    _customerId.clear();
  }

  _customerDetails(context, index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Name:'), Text(_customerNames[index])],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Address:'), Text(_customerAddress[index])],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email:'),
                  Text(_customerEmail[index] ?? 'No Email')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Phone:'), Text(_phoneNumber[index])],
              ),
            ],
          )),
        );
      },
    );
  }
}

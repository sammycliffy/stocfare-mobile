import 'package:flutter/material.dart';
import 'package:stockfare_mobile/services/product_services.dart';

class CurrentBranch extends StatefulWidget {
  @override
  _CurrentBranchState createState() => _CurrentBranchState();
}

class _CurrentBranchState extends State<CurrentBranch> {
  ProductServices _productServices = ProductServices();
  String branchName;
  String branchAddress;
  bool isInstructionView;
  @override
  void initState() {
    super.initState();
    isInstructionView = Global.shared.isInstructionView;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Update Current Branch')),
        body: Form(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (val) => setState(() {
                  branchName = val;
                }),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon:
                      Icon(Icons.person, color: Theme.of(context).accentColor),
                  hintText: 'Branch Name',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.5))),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (val) => setState(() {
                  branchAddress = val;
                }),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon:
                      Icon(Icons.person, color: Theme.of(context).accentColor),
                  hintText: 'Branch Address',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.5))),
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: Switch(
                  value: isInstructionView,
                  onChanged: (bool isOn) {
                    print(isOn);
                    setState(() {
                      isInstructionView = isOn;
                      Global.shared.isInstructionView = isOn;
                      isOn = !isOn;
                      print(isInstructionView);
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.grey,
                ),
              ),
              Text(
                'Do you want to be notified on sales?',
                style: TextStyle(fontSize: 17),
              )
            ]),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                child: Center(
                  child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                onTap: () async {
                  _productServices
                      .updateBranch(
                          branchName, branchAddress, isInstructionView)
                      .then((value) {
                    print(value);
                  });
                }),
          ],
        )));
  }
}

class Global {
  static final shared = Global();
  bool isInstructionView = false;
}

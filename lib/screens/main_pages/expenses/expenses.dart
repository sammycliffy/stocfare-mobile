import 'package:flutter/material.dart';

class ExpensesHomePage extends StatefulWidget {
  @override
  _ExpensesHomePageState createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  String paymentMethod = 'Select Expense';
  DateTime selectedDate = DateTime.now();
  bool _isNew = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => expensesForm(),
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.black),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Container(
                    height: 120,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _container('Today'),
                              _container('Week'),
                              _container('Month')
                            ]),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 10),
                          child: Text(
                            '200,000.00',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0),
                child: Text(
                  'QUICK CATEGORIES',
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 350,
                    height: 120,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey[200]),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _categories('Fuel'),
                        SizedBox(height: 5),
                        _categories('Food'),
                        SizedBox(height: 5),
                        _categories('Transport'),
                        SizedBox(height: 5),
                        _categories('Clothes')
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, top: 10),
                child: Text(
                  'RECENT ACTIVITIES',
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
              ),
              _listTile('Food', '23/07/2019', 'N125000'),
              _listTile('Food', '23/07/2019', 'N125000'),
              _listTile('Food', '23/07/2019', 'N125000')
            ],
          ),
        ));
  }

  _container(day) => Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        height: 30,
        width: 80,
        child: Center(
            child: Text(day,
                style: TextStyle(color: Theme.of(context).primaryColor))),
      );

  _listTile(name, date, amount) => Center(
        child: Container(
          width: 350,
          height: 70,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey[300]))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(amount,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey[800])),
                ],
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      );
  _categories(name) => Column(
        children: [
          Container(
            child: Container(
              width: 60,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.grey[200]),
              child: Icon(Icons.attach_money),
            ),
          ),
          Text(name,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 16)),
        ],
      );

  expensesForm() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 5),
                      Text('Back'),
                      SizedBox(width: 30),
                      Text('RECORD EXPENSES',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[600]))
                    ],
                  ),
                  Form(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: 370,
                          child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    value: paymentMethod,
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 4,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        paymentMethod = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'Select Expense',
                                      'Food',
                                      'Transportation',
                                      'Fuel',
                                      'Salary'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style: TextStyle(fontSize: 16)),
                                      );
                                    }).toList(),
                                  ))),
                        ),
                        _isNew
                            ? GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 200),
                                  child: Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                        child: Text('Close',
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _isNew = false;
                                  });
                                })
                            : GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 200),
                                  child: Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                        child: Text('Add new',
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _isNew = true;
                                  });
                                }),
                        SizedBox(height: 10),
                        _isNew
                            ? TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                validator: (input) =>
                                    input.isEmpty ? "Enter Name" : null,
                                onChanged: (val) => setState(() {}),
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  contentPadding: EdgeInsets.all(12),
                                  labelStyle:
                                      TextStyle(color: Colors.grey[600]),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.2))),
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.7)),
                                  hintText: 'Food',
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
                              )
                            : SizedBox(),
                        SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? "Enter Amount" : null,
                          onChanged: (val) => setState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            hintText: '12,000.00',
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
                        SizedBox(height: 20),
                        Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${selectedDate.toLocal()}".split(' ')[0],
                                    style: TextStyle(color: Colors.grey[600])),
                                IconButton(
                                  icon: Icon(Icons.date_range,
                                      color: Colors.grey[600]),
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                )
                              ],
                            )),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              input.isEmpty ? "Description" : null,
                          onChanged: (val) => setState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Description',
                            contentPadding: EdgeInsets.all(12),
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.2))),
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.7)),
                            hintText: 'Description',
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
                        SizedBox(height: 10),
                        Container(
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text('Done',
                                  style: TextStyle(color: Colors.white))),
                        )
                      ],
                    ),
                  )
                ],
              )),
            );
          },
        );
      },
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}

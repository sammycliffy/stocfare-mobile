import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/create_sales_model.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/services/activities_services.dart';

import '../home.dart';

class SalesReceipt extends StatefulWidget {
  final dynamic value;
  SalesReceipt({Key key, @required this.value}) : super(key: key);

  @override
  _SalesReceiptState createState() => _SalesReceiptState();
}

class _SalesReceiptState extends State<SalesReceipt> {
  ActivitiesServices _activitiesServices = ActivitiesServices();
  List _names = [];
  List dateCreated = [];
  List price = [];
  List registeredBy = [];
  List amountSold = [];
  List quantitySold = [];
  List customer = [];
  List customerChange = [];
  List referenceCode = [];
  List tax = [];
  List soldOnCredit = [];
  List amountPaid = [];
  List totalAmount = [];
  bool _error = false;
  bool _isNetwork = true;
  String _errorMessage = '';
  CreateSalesModel _createSales;

  @override
  void initState() {
    super.initState();
    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
        if (widget.value is String) {
          setState(() {
            _error = true;
            _errorMessage = widget.value;
          });
        } else {
          setState(() {
            _createSales = widget.value;
          });
        }
      } else {
        setState(() {
          _isNetwork = false;
        });
      }
    });
  }

  void _shareDocument(_signupNotifier, snapshot, amount) async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(children: [
              pw.Text(
                _signupNotifier.fullName ?? '',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'REF:  ${_createSales.refCode}',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
              ),
              pw.Text(
                Jiffy(_createSales.dateCreated).yMMMMEEEEdjm,
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 30, top: 10),
                    child: pw.Text(
                      'ITEMS',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      'PRICE',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                  )
                ],
              ),
              for (var name in _createSales.productDetail)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, top: 10),
                      child: pw.Text(
                        name.name.toString() +
                            ' ' +
                            name.quantityBought.toString(),
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        name.totalCost.toString(),
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                    )
                  ],
                ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 30, top: 10),
                    child: pw.Text(
                      'Customer',
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  if (_createSales.customer != null)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        _createSales.customer['name'],
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 30, top: 10),
                    child: pw.Text(
                      'Change',
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      _createSales.change.toString(),
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 30, top: 10),
                    child: pw.Text(
                      'Seller',
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      _createSales.saleRegisteredBy,
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 30, top: 10),
                    child: pw.Text(
                      'Sold on Credit',
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      _createSales.soldOnCredit.toString(),
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Container(
                height: 120,
                width: 350,
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 30, top: 10),
                          child: pw.Text(
                            'VAT',
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 30, top: 10),
                          child: pw.Text(
                            _createSales.tax,
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 30, top: 10),
                          child: pw.Text(
                            'YOU OWE',
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 30, top: 5),
                          child: pw.Text(
                            _createSales.change,
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 30, top: 10),
                          child: pw.Text(
                            'TOTAL',
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 30, top: 5),
                          child: pw.Text(
                            amount,
                            style: pw.TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ])));
    await Printing.sharePdf(bytes: doc.save(), filename: 'receipt.pdf');
  }

  @override
  Widget build(BuildContext context) {
    AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    var controller = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    return WillPopScope(
      onWillPop: () {
        _addProduct.items.clear();
        _addProduct.quantityToSell.clear();
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomNavigationPage()));
      },
      child: _error
          ? Scaffold(
              appBar: AppBar(
                title: Text('Receipt'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: Text(_errorMessage))],
              ))
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('Receipt'),
                actions: <Widget>[
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: null,
                            color: Colors.white,
                          ),
                          Text('Share'),
                        ],
                      ),
                    ),
                    onTap: () {
                      _shareDocument(
                          _signupNotifier, _createSales, controller.text);
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.print),
                              onPressed: () {
                                _printDocument(_signupNotifier, _createSales,
                                    controller.text);
                              },
                              color: Colors.white),
                          Text('Print'),
                        ],
                      ),
                    ),
                    onTap: () {
                      _printDocument(
                          _signupNotifier, _createSales, controller.text);
                    },
                  )
                ],
              ),
              body: (() {
                if (_isNetwork == false) {
                  return Center(
                      child: Text('Please check your internet connection'));
                } else if (_error == true) {
                  return Center(child: Text(_errorMessage));
                } else {
                  controller.updateValue(double.parse(_createSales.amount));
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            _signupNotifier.fullName ?? '',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'REF:  ${_createSales.refCode}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            Jiffy(_createSales.dateCreated).yMMMMEEEEdjm,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 350,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 10),
                                child: Text(
                                  'ITEMS',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 10),
                                child: Text(
                                  'PRICE',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          for (var name in _createSales.productDetail)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                    name.name.toString() +
                                        ' ' +
                                        name.quantityBought.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 10),
                                  child: Text(
                                    name.totalCost.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 10),
                                child: Text(
                                  'Customer',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (_createSales.customer != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 10),
                                  child: Text(
                                    _createSales.customer['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 10),
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 10),
                                child: Text(
                                  _createSales.change,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 10),
                                child: Text(
                                  'Seller',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 10),
                                child: Text(
                                  _createSales.saleRegisteredBy,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 10),
                                child: Text(
                                  'Sold on Credit',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 10),
                                child: Text(
                                  _createSales.soldOnCredit.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 10),
                                child: Text(
                                  'Amount Paid',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 10),
                                child: Text(
                                  _createSales.amountPaid,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 120,
                              width: 350,
                              decoration:
                                  BoxDecoration(border: Border.all(width: 2)),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 10),
                                        child: Text(
                                          'VAT',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 30, top: 10),
                                        child: Text(
                                          _createSales.tax,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 10),
                                        child: Text(
                                          'YOU OWE',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 30, top: 5),
                                        child: Text(
                                          _createSales.change,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 10),
                                        child: Text(
                                          'TOTAL',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 30, top: 5),
                                        child: Text(
                                          controller.text,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Sora',
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                  onPressed: () {
                                    _addProduct.items.clear();
                                    _addProduct.quantityToSell.clear();
                                    _signupNotifier.setPageNumber(1);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigationPage()));
                                  },
                                  child: Text('Make Another Sales')),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              }())),
    );
  }

  void _printDocument(_signupNotifier, snapshot, amount) {
    Printing.layoutPdf(onLayout: (pageFormat) {
      final doc = pw.Document();

      doc.addPage(pw.Page(
          build: (pw.Context context) => pw.Column(children: [
                pw.Text(
                  _signupNotifier.fullName ?? '',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  'REF:  ${_createSales.refCode}',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18),
                ),
                pw.Text(
                  Jiffy(_createSales.dateCreated).yMMMMEEEEdjm,
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 14),
                ),
                pw.SizedBox(
                  height: 20,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, top: 10),
                      child: pw.Text(
                        'ITEMS',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        'PRICE',
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                    )
                  ],
                ),
                for (var name in _createSales.productDetail)
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 30, top: 10),
                        child: pw.Text(
                          name.name.toString() +
                              ' ' +
                              name.quantityBought.toString(),
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 30, top: 10),
                        child: pw.Text(
                          name.totalCost.toString(),
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, top: 10),
                      child: pw.Text(
                        'Customer',
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (_createSales.customer != null)
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 30, top: 10),
                        child: pw.Text(
                          _createSales.customer['name'],
                          style: pw.TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, top: 10),
                      child: pw.Text(
                        'Change',
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        _createSales.change.toString(),
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, top: 10),
                      child: pw.Text(
                        'Seller',
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        _createSales.saleRegisteredBy,
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, top: 10),
                      child: pw.Text(
                        'Sold on Credit',
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        _createSales.soldOnCredit.toString(),
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Container(
                  height: 120,
                  width: 350,
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(left: 30, top: 10),
                            child: pw.Text(
                              'VAT',
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(right: 30, top: 10),
                            child: pw.Text(
                              _createSales.tax,
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(left: 30, top: 10),
                            child: pw.Text(
                              'YOU OWE',
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(right: 30, top: 5),
                            child: pw.Text(
                              _createSales.change,
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(left: 30, top: 10),
                            child: pw.Text(
                              'TOTAL',
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(right: 30, top: 5),
                            child: pw.Text(
                              amount,
                              style: pw.TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ])));

      return doc.save();
    });
  }
}

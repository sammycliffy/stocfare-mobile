import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/create_sales_model.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/services/activities_services.dart';

class SalesReceipt extends StatefulWidget {
  final Future<CreateSalesModel> value;
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

  @override
  void initState() {
    super.initState();
    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
        print(widget.value.then((value) {
          if (value == null) {
            setState(() {
              _error = true;
            });
          }
        }));
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
                'REF:  ${snapshot.data.refCode}',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
              ),
              pw.Text(
                Jiffy(snapshot.data.dateCreated).yMMMMEEEEdjm,
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
              for (var name in snapshot.data.productDetail)
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
                  if (snapshot.data.customer != null)
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        snapshot.data.customer['name'],
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
                      snapshot.data.change.toString(),
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
                      snapshot.data.saleRegisteredBy,
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
                      snapshot.data.soldOnCredit.toString(),
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
                            snapshot.data.tax,
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
                            snapshot.data.change,
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
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Receipt'),
            actions: <Widget>[
              FutureBuilder<CreateSalesModel>(
                  future: widget.value,
                  builder: (context, snapshot) {
                    return GestureDetector(
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
                            _signupNotifier, snapshot, controller.text);
                      },
                    );
                  }),
              FutureBuilder<CreateSalesModel>(
                  future: widget.value,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.print),
                                onPressed: () {
                                  _printDocument(_signupNotifier, snapshot,
                                      controller.text);
                                },
                                color: Colors.white),
                            Text('Print'),
                          ],
                        ),
                      ),
                      onTap: () {
                        _printDocument(
                            _signupNotifier, snapshot, controller.text);
                      },
                    );
                  })
            ],
          ),
          body: (() {
            if (_isNetwork == false) {
              return Center(
                  child: Text('Please check your internet connection'));
            } else if (_error == true) {
              return Center(
                  child: Text('You do not have access to veiw this page'));
            } else {
              return FutureBuilder<CreateSalesModel>(
                  future: widget.value,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      controller
                          .updateValue(double.parse(snapshot.data.amount));
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
                                'REF:  ${snapshot.data.refCode}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                Jiffy(snapshot.data.dateCreated).yMMMMEEEEdjm,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 10),
                                    child: Text(
                                      'ITEMS',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, top: 10),
                                    child: Text(
                                      'PRICE',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              for (var name in snapshot.data.productDetail)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 30, top: 10),
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
                                      padding: const EdgeInsets.only(
                                          right: 30, top: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 10),
                                    child: Text(
                                      'Customer',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  if (snapshot.data.customer != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 30, top: 10),
                                      child: Text(
                                        snapshot.data.customer['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
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
                                      'Change',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, top: 10),
                                    child: Text(
                                      snapshot.data.change,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
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
                                      'Seller',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, top: 10),
                                    child: Text(
                                      snapshot.data.saleRegisteredBy,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
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
                                      'Sold on Credit',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, top: 10),
                                    child: Text(
                                      snapshot.data.soldOnCredit.toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
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
                                      'Amount Paid',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 30, top: 10),
                                    child: Text(
                                      snapshot.data.amountPaid,
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
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2)),
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
                                              snapshot.data.tax,
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
                                              snapshot.data.change,
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
                              RaisedButton(
                                  onPressed: () {
                                    _addProduct.items.clear();
                                    _addProduct.quantityToSell.clear();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigationPage()));
                                  },
                                  child: Text('Make Another Sales'))
                            ],
                          ),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  });
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
                  'REF:  ${snapshot.data.refCode}',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18),
                ),
                pw.Text(
                  Jiffy(snapshot.data.dateCreated).yMMMMEEEEdjm,
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
                for (var name in snapshot.data.productDetail)
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
                    if (snapshot.data.customer != null)
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 30, top: 10),
                        child: pw.Text(
                          snapshot.data.customer['name'],
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
                        snapshot.data.change.toString(),
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
                        snapshot.data.saleRegisteredBy,
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
                        snapshot.data.soldOnCredit.toString(),
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
                              snapshot.data.tax,
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
                              snapshot.data.change,
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

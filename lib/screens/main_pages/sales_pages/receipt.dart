import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_pages/all_sales.dart';
import 'package:stockfare_mobile/services/sales_services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class AllProductsList extends StatefulWidget {
  final int customerIndex;
  final List names;
  final List dateCreated;
  final List price;
  final List sellerNames;
  final List amountSold;
  final List quantitySold;
  final List customerNames;
  final List customerChange;
  final List referenceCode;
  final List tax;
  final List soldOnCredit;
  final List amountPaid;

  AllProductsList({
    Key key,
    @required this.customerIndex,
    @required this.names,
    @required this.dateCreated,
    @required this.price,
    @required this.sellerNames,
    @required this.amountSold,
    @required this.quantitySold,
    @required this.customerNames,
    @required this.customerChange,
    @required this.referenceCode,
    @required this.tax,
    @required this.soldOnCredit,
    @required this.amountPaid,
  }) : super(key: key);
  @override
  _AllProductsListState createState() => _AllProductsListState();
}

class _AllProductsListState extends State<AllProductsList> {
  SalesServices _salesServices = SalesServices();

  Future<GetSalesModel> salesList;

  void _shareDocument(_signupNotifier) async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
        build: (pw.Context context) => pw.Column(children: [
              pw.Text(
                _signupNotifier.fullName ?? '',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'REF:  ${widget.referenceCode[widget.customerIndex]}',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
              ),
              pw.Text(
                DateFormat('yyyy-MM-dd @ kk:mm')
                    .format(widget.dateCreated[widget.customerIndex])
                    .toString(),
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
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      for (var name in widget.names[widget.customerIndex])
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
                    ],
                  ),
                  pw.Column(
                    children: [
                      for (var cost in widget.names[widget.customerIndex])
                        pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 30, top: 10),
                          child: pw.Text(
                            cost.totalCost.toString(),
                            style: pw.TextStyle(
                                fontSize: 16, fontWeight: pw.FontWeight.bold),
                          ),
                        )
                    ],
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
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      widget.customerNames[widget.customerIndex].toString(),
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
                      'Change',
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      widget.customerChange[widget.customerIndex].toString(),
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
                      widget.sellerNames[widget.customerIndex].toString(),
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
                      widget.soldOnCredit[widget.customerIndex].toString(),
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
                            widget.tax[widget.customerIndex].toString(),
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
                            widget.customerChange[widget.customerIndex]
                                .toString(),
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
                            widget.amountSold[widget.customerIndex].toString(),
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
    print(widget.names[widget.customerIndex]);
    SignupNotifier _signupNotifier = Provider.of<SignupNotifier>(context);
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => AllSalesList())),
      child: Scaffold(
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
                  _shareDocument(_signupNotifier);
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
                            _printDocument(_signupNotifier);
                          },
                          color: Colors.white),
                      Text('Print'),
                    ],
                  ),
                ),
                onTap: () {
                  _printDocument(_signupNotifier);
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  _signupNotifier.fullName ?? '',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'REF:  ${widget.referenceCode[widget.customerIndex]}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  DateFormat('yyyy-MM-dd @ kk:mm')
                      .format(widget.dateCreated[widget.customerIndex])
                      .toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.grey))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'ITEMS',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child: Text(
                        'PRICE',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        for (var name in widget.names[widget.customerIndex])
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              name.name.toString() +
                                  ' ' +
                                  name.quantityBought.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      children: [
                        for (var cost in widget.names[widget.customerIndex])
                          Padding(
                            padding: const EdgeInsets.only(right: 30, top: 10),
                            child: Text(
                              cost.totalCost.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Customer',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child: Text(
                        widget.customerNames?.elementAt(widget.customerIndex) ??
                            "None",
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
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child: Text(
                        widget.customerChange[widget.customerIndex].toString(),
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
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Seller',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child: Text(
                        widget.sellerNames[widget.customerIndex].toString(),
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
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Sold on Credit',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child: Text(
                        widget.soldOnCredit[widget.customerIndex].toString(),
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
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Text(
                        'Amount Paid',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, top: 10),
                      child: Text(
                        widget.amountPaid[widget.customerIndex].toString(),
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
                    decoration: BoxDecoration(border: Border.all(width: 2)),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text(
                                'VAT',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, top: 10),
                              child: Text(
                                widget.tax[widget.customerIndex].toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text(
                                'YOU OWE',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30, top: 5),
                              child: Text(
                                widget.customerChange[widget.customerIndex]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10),
                              child: Text(
                                'TOTAL',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30, top: 5),
                              child: Text(
                                widget.amountSold[widget.customerIndex]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Sora',
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 60)
              ],
            ),
          )),
    );
  }

  void _printDocument(_signupNotifier) {
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
                  'REF:  ${widget.referenceCode[widget.customerIndex]}',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18),
                ),
                pw.Text(
                  DateFormat('yyyy-MM-dd @ kk:mm')
                      .format(widget.dateCreated[widget.customerIndex])
                      .toString(),
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
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        for (var name in widget.names[widget.customerIndex])
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(left: 30, top: 10),
                            child: pw.Text(
                              name.name.toString() +
                                  ' ' +
                                  name.quantityBought.toString(),
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    pw.Column(
                      children: [
                        for (var cost in widget.names[widget.customerIndex])
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.only(right: 30, top: 10),
                            child: pw.Text(
                              cost.totalCost.toString(),
                              style: pw.TextStyle(
                                  fontSize: 16, fontWeight: pw.FontWeight.bold),
                            ),
                          )
                      ],
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
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        widget.customerNames[widget.customerIndex].toString(),
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
                        'Change',
                        style: pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        widget.customerChange[widget.customerIndex].toString(),
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
                        widget.sellerNames[widget.customerIndex].toString(),
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
                        widget.soldOnCredit[widget.customerIndex].toString(),
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
                              widget.tax[widget.customerIndex].toString(),
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
                              widget.customerChange[widget.customerIndex]
                                  .toString(),
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
                              widget.amountSold[0].toString(),
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

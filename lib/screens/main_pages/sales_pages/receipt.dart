import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/services/sales_services.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class AllProductsList extends StatefulWidget {
  final int customerIndex;
  AllProductsList({Key key, @required this.customerIndex}) : super(key: key);
  @override
  _AllProductsListState createState() => _AllProductsListState();
}

class _AllProductsListState extends State<AllProductsList> {
  SalesServices _salesServices = SalesServices();

  Future<GetSalesModel> salesList;
  List names = [];
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
                'REF:  ${referenceCode[widget.customerIndex]}',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18),
              ),
              pw.Text(
                DateFormat('yyyy-MM-dd @ kk:mm')
                    .format(dateCreated[widget.customerIndex])
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
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 30, top: 10),
                    child: pw.Text(
                      names[widget.customerIndex].toString() +
                          ' ' +
                          quantitySold[widget.customerIndex].toString(),
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      price[widget.customerIndex].toString(),
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
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(right: 30, top: 10),
                    child: pw.Text(
                      customer[widget.customerIndex].toString(),
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
                      customerChange[widget.customerIndex].toString(),
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
                      registeredBy[widget.customerIndex].toString(),
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
                      soldOnCredit[widget.customerIndex].toString(),
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
                            tax[widget.customerIndex].toString(),
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
                            customerChange[widget.customerIndex].toString(),
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
                            totalAmount[widget.customerIndex].toString(),
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
  void initState() {
    super.initState();
    salesList = _salesServices.getallSales();
    print(salesList.then((value) {
      print(value.results.map((data) {
        registeredBy.add(data.saleRegisteredBy);
        amountSold.add(data.amount);
        referenceCode.add(data.refCode);
        customerChange.add(data.change);
        customer.add(data.customer?.name ?? '');
        soldOnCredit.add(data.soldOnCredit);
        amountPaid.add(data.amountPaid);
        tax.add(data.tax);
        quantitySold.add(data.productDetail[0].quantityBought);
        totalAmount.add(data.productDetail[0].totalCost);

        dateCreated.add(data.dateCreated);
        return (data.productData.map((name) {
          setState(() {
            names.add(name.name);
            price.add(name.productUnit.price);
          });
        }));
      }));
    }));
  }

  @override
  Widget build(BuildContext context) {
    SignupNotifier _signupNotifier = Provider.of<SignupNotifier>(context);
    return Scaffold(
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
      body: FutureBuilder<GetSalesModel>(
          future: salesList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      _signupNotifier.fullName ?? '',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'REF:  ${referenceCode[widget.customerIndex]}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd @ kk:mm')
                          .format(dateCreated[widget.customerIndex])
                          .toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 350,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            names[widget.customerIndex].toString() +
                                ' ' +
                                quantitySold[widget.customerIndex].toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, top: 10),
                          child: Text(
                            price[widget.customerIndex].toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                            'Customer',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, top: 10),
                          child: Text(
                            customer?.elementAt(widget.customerIndex) ?? "None",
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
                            customer?.elementAt(widget.customerIndex) ?? "None",
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
                            registeredBy[widget.customerIndex].toString(),
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
                            soldOnCredit[widget.customerIndex].toString(),
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
                            amountPaid[widget.customerIndex].toString(),
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
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
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
                                    tax[widget.customerIndex].toString(),
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
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                    'YOU OWE',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Sora',
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 5),
                                  child: Text(
                                    customerChange[widget.customerIndex]
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
                                  padding:
                                      const EdgeInsets.only(left: 30, top: 10),
                                  child: Text(
                                    'TOTAL',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Sora',
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 5),
                                  child: Text(
                                    totalAmount[widget.customerIndex]
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
                        ))
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
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
                  'REF:  ${referenceCode[widget.customerIndex]}',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 18),
                ),
                pw.Text(
                  DateFormat('yyyy-MM-dd @ kk:mm')
                      .format(dateCreated[widget.customerIndex])
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
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 30, top: 10),
                      child: pw.Text(
                        names[widget.customerIndex].toString() +
                            ' ' +
                            quantitySold[widget.customerIndex].toString(),
                        style: pw.TextStyle(
                            fontSize: 16, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        price[widget.customerIndex].toString(),
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
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 30, top: 10),
                      child: pw.Text(
                        customer[widget.customerIndex].toString(),
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
                        customerChange[widget.customerIndex].toString(),
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
                        registeredBy[widget.customerIndex].toString(),
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
                        soldOnCredit[widget.customerIndex].toString(),
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
                              tax[widget.customerIndex].toString(),
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
                              customerChange[widget.customerIndex].toString(),
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
                              totalAmount[widget.customerIndex].toString(),
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

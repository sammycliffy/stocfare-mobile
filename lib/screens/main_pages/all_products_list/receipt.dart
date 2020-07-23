import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
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
  Future<Welcome> salesList;
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
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  void _printDocument() {
    Printing.layoutPdf(onLayout: (pageFormat) {
      final doc = pw.Document();

      doc.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Text('This is the receipt'),
          ),
        ),
      );

      return doc.save();
    });
  }

  void _shareDocument() async {
    final doc = pw.Document();
    await Printing.sharePdf(bytes: doc.save(), filename: 'my-document.pdf');
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
        customer.add(data.customer.name);
        soldOnCredit.add(data.soldOnCredit);
        amountPaid.add(data.amountPaid);
        tax.add(data.tax);
        quantitySold.add(data.productDetail[0].quantityBought);
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
              _shareDocument();
            },
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.print),
                      onPressed: _printDocument,
                      color: Colors.white),
                  Text('Print'),
                ],
              ),
            ),
            onTap: () {
              _printDocument();
            },
          )
        ],
      ),
      body: FutureBuilder<Welcome>(
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
                      'Sammy Cliffy',
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
                            customer[widget.customerIndex].toString(),
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
                            customerChange[widget.customerIndex].toString(),
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
                                    amountPaid[widget.customerIndex].toString(),
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
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 25,
            ));
          }),
    );
  }
}

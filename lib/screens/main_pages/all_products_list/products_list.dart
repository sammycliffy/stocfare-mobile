import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/screens/intro_pages/addProducts.dart';
import 'package:stockfare_mobile/services/sales_services.dart';

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
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  void initState() {
    super.initState();
    salesList = _salesServices.getallSales();
    print(salesList.then((value) {
      print(value.results.map((data) {
        registeredBy.add(data.saleRegisteredBy);
        amountSold.add(data.amount);
        customer.add(data.customer.name);
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
          Padding(
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
          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.print),
                    onPressed: null,
                    color: Colors.white),
                Text('Print'),
              ],
            ),
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
                      'REF:',
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
                            'None',
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
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 10),
                                  child: Text(
                                    '0',
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
                                    'YOU OWE',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 5),
                                  child: Text(
                                    '0',
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
                                      const EdgeInsets.only(left: 30, top: 5),
                                  child: Text(
                                    'TOTAL',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 5),
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
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

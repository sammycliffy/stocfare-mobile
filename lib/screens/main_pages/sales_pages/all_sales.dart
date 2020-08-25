import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/receipt.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stockfare_mobile/services/sales_services.dart';

class AllSalesList extends StatefulWidget {
  const AllSalesList({Key key}) : super(key: key);
  @override
  _AllSalesListState createState() => _AllSalesListState();
}

class _AllSalesListState extends State<AllSalesList> {
  SalesServices _salesServices = SalesServices();
  Future<Welcome> salesList;
  Future<Welcome> sortedList;
  int count;
  List names = [];
  List dateCreated = [];
  List price = [];
  List registeredBy = [];
  List amountSold = [];
  List quantitySold = [];
  List customer = [];
  dynamic selectedDate = DateTime.now();
  bool filter = false;

  @override
  void initState() {
    super.initState();
    salesList = _salesServices.getallSales();
    print(salesList.then((value) {
      count = value.count;
      print(value.results.map((data) {
        registeredBy.add(data.saleRegisteredBy);
        amountSold.add(data.amount);
        customer.add(data.customer?.name ?? '');
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        filter = true;
        names.clear();
        dateCreated.clear();
        price.clear();
        registeredBy.clear();
        amountSold.clear();

        customer.clear();

        sortedList = _salesServices.sortedDates(
            (picked.toUtc().millisecondsSinceEpoch / 1000).round());
        print(sortedList.then((value) {
          count = value.count;
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('this is ist ' +
        (selectedDate.toUtc().millisecondsSinceEpoch / 1000).toString());
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerPage(),
        appBar: AppBar(
          title: Text('Sales History'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Container(
                        height: 45,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                            decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.black,
                            iconSize: 20.0,
                            onPressed: () {},
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(25, 8, 0, 5),
                          hintText: 'Search Stockfare',
                        )),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        body: Column(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                      width: 220,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Sort for sales using date'),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.date_range,
                              color: Theme.of(context).primaryColor)
                        ],
                      )),
                ),
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            Expanded(
              child: filter
                  ? FutureBuilder<Welcome>(
                      future: sortedList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.count == 0) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'No sales',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                MaterialButton(
                                    child: Text(
                                      'Go back',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.black,
                                    onPressed: () {
                                      setState(() {
                                        filter = false;
                                        salesList =
                                            _salesServices.getallSales();
                                        print(salesList.then((value) {
                                          count = value.count;
                                          print(value.results.map((data) {
                                            registeredBy
                                                .add(data.saleRegisteredBy);
                                            amountSold.add(data.amount);
                                            customer
                                                .add(data.customer?.name ?? '');
                                            quantitySold.add(data
                                                .productDetail[0]
                                                .quantityBought);
                                            dateCreated.add(data.dateCreated);
                                            return (data.productData
                                                .map((name) {
                                              setState(() {
                                                names.add(name.name);
                                                price.add(
                                                    name.productUnit.price);
                                              });
                                            }));
                                          }));
                                        }));
                                      });
                                    })
                              ],
                            );
                          }
                          return ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: names.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.card_giftcard,
                                          color:
                                              Theme.of(context).primaryColor),
                                      title: Text(
                                        names[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Sold By : ${registeredBy[index].toString()}',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Sora'),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Customer :  ${customer[index].toString()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'FireSans'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  Jiffy(dateCreated[index])
                                                      .format(
                                                          "yyyy-MM-dd HH:mm:ss"),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(Icons.more_vert),
                                      isThreeLine: true,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllProductsList(
                                                    customerIndex: index)));
                                  },
                                );
                              });
                        }

                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: CircularProgressIndicator()),
                            ]);
                      })
                  : FutureBuilder<Welcome>(
                      future: salesList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: names.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.card_giftcard,
                                          color:
                                              Theme.of(context).primaryColor),
                                      title: Text(
                                        names[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Sold By : ${registeredBy[index].toString()}',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Sora'),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Customer :  ${customer[index].toString()}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'FireSans'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6),
                                                child: Text(
                                                  Jiffy(dateCreated[index])
                                                      .format(
                                                          "yyyy-MM-dd HH:mm:ss"),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(Icons.more_vert),
                                      isThreeLine: true,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllProductsList(
                                                    customerIndex: index)));
                                  },
                                );
                              });
                        }

                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: CircularProgressIndicator()),
                            ]);
                      }),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/products_list.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';

import 'package:stockfare_mobile/services/sales_services.dart';
import 'package:intl/intl.dart';

class AllSalesList extends StatefulWidget {
  @override
  _AllSalesListState createState() => _AllSalesListState();
}

class _AllSalesListState extends State<AllSalesList> {
  SalesServices _salesServices = SalesServices();
  Future<Welcome> salesList;
  int count;
  List names = [];
  List dateCreated = [];
  List price = [];
  List registeredBy = [];
  List amountSold = [];
  List quantitySold = [];
  List customer = [];

  @override
  void initState() {
    super.initState();
    salesList = _salesServices.getallSales();
    print(salesList.then((value) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerPage(),
        appBar: AppBar(
          title: Text('Sales List'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
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
          ),
        ),
        body: count == 0
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.mood_bad,
                      size: 50,
                    ),
                    Text(
                      'You don\'t have any sales yet.',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              )
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
                                leading: FlutterLogo(size: 72.0),
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
                                          ' Customer :  ${customer[index].toString()}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'FireSans'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, top: 6),
                                          child: Text(
                                            DateFormat('yyyy-MM-dd - kk:mm')
                                                .format(dateCreated[index])
                                                .toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      children: <Widget>[
                                        SizedBox(width: 20),
                                      ],
                                    )
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
                                      builder: (context) => AllProductsList(
                                          customerIndex: index)));
                            },
                          );
                        });
                  }

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.monetization_on,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Center(
                          child: Text('All your Sales will display here',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor)),
                        ),
                      ]);
                }));
  }
}

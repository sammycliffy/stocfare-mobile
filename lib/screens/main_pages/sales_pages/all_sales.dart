import 'package:flutter/material.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/loader.dart';
import 'package:stockfare_mobile/services/sales_services.dart';
import 'package:intl/intl.dart';

class AllSalesList extends StatefulWidget {
  @override
  _AllSalesListState createState() => _AllSalesListState();
}

class _AllSalesListState extends State<AllSalesList> {
  SalesServices _salesServices = SalesServices();
  Future<Welcome> salesList;
  List names = [];
  List dateCreated = [];
  List price = [];
  List registeredBy = [];
  List amountSold = [];
  List quantitySold = [];

  @override
  void initState() {
    super.initState();
    salesList = _salesServices.getallSales();
    print(salesList.then((value) {
      print(value.results.map((data) {
        registeredBy.add(data.saleRegisteredBy);
        amountSold.add(data.amount);
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
        ),
        body: FutureBuilder<Welcome>(
            future: salesList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200]),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Image.asset(
                                    'assets/images/laptop.png',
                                    width: 80,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(names[index]),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Container(
                                          color: Theme.of(context).accentColor,
                                          height: 25,
                                          width: 70,
                                          child: Center(
                                            child: Text(
                                              amountSold[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          price[index].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          DateFormat('yyyy-MM-dd @ kk:mm')
                                              .format(dateCreated[index])
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          'Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 15),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          quantitySold[index].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          'Quantity',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          registeredBy[index].toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          'Sold by',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ));
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

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stockfare_mobile/models/analytics_model.dart';

class AnalyticsDetailsPage extends StatefulWidget {
  final SalesAnalyticsModel analyticsData;
  final String pageTitle;
  AnalyticsDetailsPage(
      {Key key, @required this.analyticsData, @required this.pageTitle})
      : super(key: key);

  @override
  _AnalyticsDetailsPageState createState() => _AnalyticsDetailsPageState();
}

class _AnalyticsDetailsPageState extends State<AnalyticsDetailsPage> {
  List dateCreated = [];
  List price = [];
  List registeredBy = [];
  List amountSold = [];
  List quantitySold = [];
  List customers = [];
  bool _error = false;
  List names = [];
  List totalCost = [];
  List quantityBought = [];

  @override
  void initState() {
    super.initState();
    names.clear();
    quantityBought.clear();
    totalCost.clear();
    if (widget.analyticsData == null) {
      setState(() {
        _error = true;
      });
    } else {
      print(widget.analyticsData?.results?.map((data) {
            registeredBy.add(data.saleRegisteredBy);
            amountSold.add(data.amount);
            // customers.add(data.customer.name ?? '');
            quantitySold.add(data.productDetail[0].quantityBought);
            names.add(data.productDetail[0].name);
            totalCost.add(data.productDetail[0].totalCost);
            quantityBought.add(data.productDetail[0].quantityBought);
            dateCreated.add(data.dateCreated);
            return (data.productData.map((name) {
              setState(() {
                price.add(name.productUnit.price);
              });
            }));
          }) ??
          '[]');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(totalCost);
    print(quantityBought);
    print(names);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.pageTitle),
        ),
        body: (() {
          if (_error == true) {
            return Column(
              children: [
                SizedBox(height: 100),
                Center(child: Icon(Icons.mood_bad, size: 40)),
                Text('No Sales',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.card_giftcard,
                            color: Theme.of(context).primaryColor),
                        title: Text(
                          names[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Total Cost : ${totalCost[index].toString()}',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Sora'),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Quantity Bought :  ${quantityBought[index].toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'FireSans'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    Jiffy(dateCreated[index])
                                        .format("yyyy-MM-dd HH:mm:ss"),
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             AllProductsList(customerIndex: index)));
                    },
                  );
                });
          }
        }()));
  }
}

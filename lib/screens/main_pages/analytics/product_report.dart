import 'package:flutter/material.dart';

import 'package:stockfare_mobile/models/product_analytics_model.dart';

class ProductsAnalyticsDetailsPage extends StatefulWidget {
  final ProductsAnalyticsList analyticsData;
  final String pageTitle;
  ProductsAnalyticsDetailsPage(
      {Key key, @required this.analyticsData, @required this.pageTitle})
      : super(key: key);

  @override
  _ProductsAnalyticsDetailsPageState createState() =>
      _ProductsAnalyticsDetailsPageState();
}

class _ProductsAnalyticsDetailsPageState
    extends State<ProductsAnalyticsDetailsPage> {
  final List _names = [];
  final List _count = [];

  @override
  void initState() {
    super.initState();
    print(widget.analyticsData.productAnalyticsModel.map((value) {
      setState(() {
        _names.add(value.name);
        _count.add(value.count);
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.pageTitle),
        ),
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemCount: _names.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Text(
                          _names[index],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          _count[index].toString() + ' pcs',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              );
            }));
  }
}

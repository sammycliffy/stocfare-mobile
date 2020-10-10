import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Help')),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'In order to quickly get you started, we have curated a few things you need to have the best Stockfare experience. ',
                style: TextStyle(fontSize: 16, height: 1.2),
                textAlign: TextAlign.justify,
              ),
            ),
            InkWell(
              child: Container(
                  width: 330,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    ' What is Stockfare?',
                    style: TextStyle(fontSize: 15),
                  ))),
              onTap: () => whatIsStockfare(context),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                  width: 330,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    ' What do we mean by Category?',
                    style: TextStyle(fontSize: 15),
                  ))),
              onTap: () {
                category(context);
              },
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                  width: 330,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'How do I add my product?',
                    style: TextStyle(fontSize: 15),
                  ))),
              onTap: () => howDoIAddProduct(context),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                  width: 330,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    'How do I make a sale?',
                    style: TextStyle(fontSize: 15),
                  ))),
              onTap: () => howDoIMakeASale(context),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                  width: 330,
                  height: 45,
                  color: Colors.white,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'How do i add my staff on my account?',
                      style: TextStyle(fontSize: 15),
                    ),
                  ))),
              onTap: () => howDoIAddWorkers(context),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                  width: 330,
                  height: 40,
                  color: Colors.white,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'What\'s the pricing plan?',
                      style: TextStyle(fontSize: 15),
                    ),
                  ))),
              onTap: () => pricingPlan(context),
            ),
          ],
        ));
  }
}

category(context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text(
              'What do you mean by Category?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'We believe in being organized, and that is why we decided the category section should help businesses stay organized. Goods should be grouped based on types. ',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'To create category, click on the "Plus" button on the Product page and fill the form ',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        )),
      );
    },
  );
}

pricingPlan(context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text(
              'What is the Pricing plan?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'We offer both free and paid services on the platform. With our free service, you are entitled to add 20 categories on the platform. To have unlimited reach of the app, you will be required to subscribe to the platform at NGN 3,000 per month. You can pay either monthly ( NGN 3,000), quarterly (NGN 12,000)  or annually( NGN 36,000). ',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        )),
      );
    },
  );
}

whatIsStockfare(context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text(
              'What is Stockfare?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Stockfare is a smart sales/ business analysis app that allows small and medium scale enterprises to manage their inventories, profit and loss, expenses a lot more to give a total business management package all on the go. \n We have brought revolution to the regular brick and mortar stores in Africa, and we are on a mission to increase technology acceptance amongst locals while offering them value.',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        )),
      );
    },
  );
}

howDoIAddWorkers(context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text(
              'How do I add workers?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Go to the side menu bar, you will find workers options, click on this and you will be directed to the workers page. Fill in details accordingly. You will choose activities that your want each worker to perform.',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        )),
      );
    },
  );
}

howDoIAddProduct(context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text(
              'How do I add products?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'To add products, click on the + (plus) button on the dashboard. You will be directed to add your products individually or by uploading an excel. You can scan products with barcodes and capture product pictures too.',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        )),
      );
    },
  );
}

howDoIMakeASale(context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Text(
              'How do I make a sale?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'To sell a product you can quickly scan the product barcode or click on the picture displays on your dashboard. If you are selling more than one of a product, click as many times as possible to add to cart. When this is done, click  ‘Checkout’ to finish the sale. \nYou may choose to enter your customer details, if the customer is buying on credit you can register this and also a date of payment. \nYou may now complete sale and share receipt to your customer or print using a portable bluetooth device.',
              style: TextStyle(color: Colors.black, fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        )),
      );
    },
  );
}

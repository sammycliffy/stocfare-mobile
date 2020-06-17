import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/second_intro.dart';

class FirstIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Row(
                  children: [
                    ClipOval(
                        child: Image.asset(
                      'assets/images/funke.jpeg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.fill,
                    )),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          'Funke Akindele       ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Shop Owner               ',
                            style: TextStyle(color: Colors.red, fontSize: 13)),
                        Text(
                          'Stockfare App User      ',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi There,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Managing your goods is now very easy. You never have to run out of your best selling  goods. Notifications will be sent to you when your goods have reached a limit or when you have run out of stock so you can quickly restock. ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'StockFare is dedicated to improving the way businesses in Africa operate, by combining technology with amazing user experience to creating a well thought out product, that ensures your business says thanks to you. ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/firstintro.png',
                          width: 250,
                          height: 250,
                        ),
                      ),
                      GestureDetector(
                          child: Center(
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                'Explore',
                                style: TextStyle(color: Colors.red),
                              )),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondIntro()));
                          })
                    ]),
              )
            ],
          ),
        ));
  }
}

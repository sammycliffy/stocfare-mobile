import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/intro_pages/fourth_intro.dart';
import 'common_intro_widgets/all_products_appbar.dart';

class AllProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBarAllProducts(),
          )),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Center(
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Container(
                  width: 400,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              'assets/images/laptop.png',
                              width: 80,
                              height: 80,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            child: Text(
                              'HP Laptop',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 3, color: Colors.grey))),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 0),
                                  child: Text(
                                    'Available Stock',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 50, top: 2),
                                  child: Text(
                                    '234',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.green),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, top: 10),
                                  child: Text(
                                    'Barcode',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 50, top: 2),
                                  child: Text(
                                    'Nil',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.green,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 36),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 50, top: 10),
                              child: Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 50, top: 2),
                              child: Text(
                                'Electricity',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 40, top: 10),
                              child: Text(
                                'Stock Alert',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 80, top: 2),
                              child: Text(
                                '12',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.green,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: FourthIntroPage()));
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}

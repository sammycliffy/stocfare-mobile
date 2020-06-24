import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/intro_pages/fourth_intro.dart';
import 'common_intro_widgets/app_bar.dart';

class MultiplePage extends StatefulWidget {
  @override
  _MultiplePageState createState() => _MultiplePageState();
}

class _MultiplePageState extends State<MultiplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(10.0),
            child: AppBarProducts(),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Center(
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Icon(Icons.add_a_photo,
                          color: Colors.grey, size: 70)),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: FourthIntroPage()));
              },
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 250,
              ),
              child: Text(
                'Upload more than one product',
                style: TextStyle(fontSize: 14),
              ),
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

import 'package:flutter/material.dart';
import 'package:stockfare_mobile/intro_pages/third_intro.dart';

class FourthIntroPage extends StatefulWidget {
  @override
  _FourthIntroPageState createState() => _FourthIntroPageState();
}

class _FourthIntroPageState extends State<FourthIntroPage> {
  double _value = 0;
  double _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 50),
            child: Container(
              height: 40,
              width: 320,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red, width: 3)),
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                      ),
                      child: Center(
                          child: Text(
                        'Add Single Product',
                        style: TextStyle(color: Colors.red),
                      )),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Center(
                          child: Text(
                        'Add Multiple Product',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ThirdIntro()));
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ExpansionTile(
                title: Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Image.asset('assets/images/laptop.png',
                      width: 50, height: 50),
                ),
                children: [
                  ListTile(
                    title: Form(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                                validator: (val) => val.length < 11
                                    ? 'Enter a valid Phone no'
                                    : null,
                                decoration: InputDecoration(
                                  hintText: 'Enter product name',
                                  filled: true,
                                  border: InputBorder.none,
                                )),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                                validator: (val) => val.length < 11
                                    ? 'Enter a valid Phone no'
                                    : null,
                                decoration: InputDecoration(
                                  hintText: 'Unit Price',
                                  filled: true,
                                  border: InputBorder.none,
                                )),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: TextFormField(
                                validator: (val) => val.length < 11
                                    ? 'Enter a valid Phone no'
                                    : null,
                                decoration: InputDecoration(
                                  hintText: 'Enter product Category',
                                  filled: true,
                                  border: InputBorder.none,
                                )),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 180),
                            child: Text(
                              'Quantity in Stock',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(children: [
                              Text(
                                'Total Products available in Stock',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                              SizedBox(width: 40),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Text(
                                  (_value * 1000).round().toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                              )
                            ]),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.grey[400],
                              inactiveTrackColor: Colors.grey[400],
                              trackShape: RectangularSliderTrackShape(),
                              trackHeight: 4.0,
                              thumbColor: Colors.redAccent,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              overlayColor: Colors.red,
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                            ),
                            child: Slider(
                              value: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 180),
                            child: Text(
                              'Low Stock Alert',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(children: [
                              Text(
                                'When to alert on low stock',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                              SizedBox(width: 70),
                              Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                    child: Text(
                                  (_quantity * 1000).round().toString(),
                                  style: TextStyle(color: Colors.white),
                                )),
                              )
                            ]),
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.grey[400],
                              inactiveTrackColor: Colors.grey[400],
                              trackShape: RectangularSliderTrackShape(),
                              trackHeight: 4.0,
                              thumbColor: Colors.redAccent,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              overlayColor: Colors.red,
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 28.0),
                            ),
                            child: Slider(
                              value: _quantity,
                              onChanged: (value) {
                                setState(() {
                                  _quantity = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

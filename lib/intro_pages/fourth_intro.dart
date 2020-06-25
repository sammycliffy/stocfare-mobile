import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stockfare_mobile/intro_pages/success_product.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'common_intro_widgets/app_bar.dart';

class FourthIntroPage extends StatefulWidget {
  @override
  _FourthIntroPageState createState() => _FourthIntroPageState();
}

class _FourthIntroPageState extends State<FourthIntroPage> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildListView(_value, _quantity) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          Asset asset = images[index];
          return ExpansionTile(
            title: Padding(
              padding: const EdgeInsets.only(right: 230),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
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
                            style: TextStyle(fontSize: 12, color: Colors.red),
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
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
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
                            style: TextStyle(fontSize: 12, color: Colors.red),
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
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
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
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 200),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Icon(Icons.assessment,
                                    color: Colors.grey, size: 40)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Text('Add Barcode'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#c80815",
          actionBarTitle: "Stockfare",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  double _quantity = 0;
  double _value = 0;

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
        children: <Widget>[
          Center(child: Text('Error: $_error')),
          RaisedButton(
            child: Text("Pick images"),
            onPressed: loadAssets,
          ),
          Expanded(
            child: buildListView(_quantity, _value),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              child: Center(
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'Add all Products',
                    style: TextStyle(color: Colors.red),
                  )),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.leftToRight,
                        child: SuccessProduct()));
              }),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SuccessProduct(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      return child;
    },
  );
}

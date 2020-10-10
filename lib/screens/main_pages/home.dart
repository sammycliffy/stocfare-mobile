import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_pages/cart.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:stockfare_mobile/services/product_services.dart';
import 'all_products_list/add_single_products/form.dart';
import 'sales_pages/all_sales.dart';

enum SingingCharacter { pack, unit }

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

// Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
//   return _HomePageState()._showNotification(message);
// }

class _HomePageState extends State<HomePage> {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  SignupNotifier _signupNotifier;
  dynamic dataInstance;
  List _topCategory = [];
  List _categories = [];
  List _productName = [];
  List _productPrice = [];
  List _productImage = [];
  List _productQuantity = [];
  List _packQuantity = [];
  List _productId = [];
  List _productPackPrice = [];
  List _barcode = [];
  List _categoriesSearch = [];
  List _productNameSearch = [];
  List _productPriceSearch = [];
  List _productImageSearch = [];
  List _productQuantitySearch = [];
  List _packQuantitySearch = [];
  List _productIdSearch = [];
  List _productPackPriceSearch = [];
  List _unitCostPriceSearch = [];
  List _packCostPriceSearch = [];
  List _barcodeSearch = [];
  List _unitCostPrice = [];
  List _packCostPrice = [];
  bool newvalue = false;
  List<Map<String, dynamic>> items = [];
  List _items = [];
  List _quantityToSell = [];
  bool isSearched = false;
  int _shoppingCartPackQuantity = 0;
  int _shoppingCartUnitQuantity = 0;
  int numberToFormat = 100000;

  String _scanBarcode = 'Unknown';
  Map<String, dynamic> _firebaseMessage;
  final _formKey = GlobalKey<FormState>();
  String firebaseNumber;
  ProductServices _productServices = ProductServices();

  // Future selectNotification(String payload) async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }

  // Future _showNotification(Map<String, dynamic> message) async {
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       'channelId', 'channelName', 'channelDescription',
  //       importance: Importance.Max, priority: Priority.High);

  //   var platformChannelSpecifics =
  //       new NotificationDetails(androidPlatformChannelSpecifics, null);

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     message['notification']['title'],
  //     message['notification']['body'],
  //     platformChannelSpecifics,
  //     payload: 'Default_Sound',
  //   );
  // }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      searchBarcode(barcodeScanRes);
    });
  }

  @override
  void initState() {
    super.initState();
    // var initializationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettings =
    //     InitializationSettings(initializationSettingsAndroid, null);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: selectNotification);

    _firebaseMessaging.configure(
        // onBackgroundMessage: myBackgroundHandler,
        onMessage: (Map<String, dynamic> message) async {
      // print('onMessage: ${message['notification']['body']}');
      _firebaseMessage = message;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(message['notification']['title']),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(message['notification']['body']),
                    RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('See Receipt'))
                  ],
                ),
              ),
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.2;
    final double itemWidth = size.width / 2;
    AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);
    var controller = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    var controller1 = new MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',',
        leftSymbol: ' ${_signupNotifier.country} ');
    final firebaseDb =
        _productServices.getFirebaseData(_signupNotifier.firebaseId);

    return WillPopScope(
      onWillPop: () => SystemNavigator.pop(),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            focusColor: Theme.of(context).canvasColor,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FormPage()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: Colors.black,
          ),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.0), // here the desired height
              child: AppBar(
                elevation: 0.0,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'Checkout',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text('Sales History',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllSalesList()));
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Container(
                              height: 50,
                              width: 280,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200],
                              ),
                              child: TextFormField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        search(val);
                                      });
                                    } else if (val.length <= 0) {
                                      setState(() {
                                        isSearched = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                      icon: Icon(Icons.search),
                                      color: Colors.black,
                                      iconSize: 20.0,
                                      onPressed: () {},
                                    ),
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(25, 8, 0, 5),
                                    hintText: 'Search Stockfare',
                                  )),
                            ),
                          ),
                          SizedBox(width: 10),
                          Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, right: 20),
                              child: InkWell(
                                child: Container(
                                  width: 50,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: IconButton(
                                          icon: FaIcon(FontAwesomeIcons.barcode,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: null)),
                                ),
                                onTap: () {
                                  scanBarcodeNormal();
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
          drawer: DrawerPage(),
          body: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 5),
                  InkWell(
                    child: Container(
                      width: 250,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Finish',
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              _addProduct.quantityToSell?.length == null
                                  ? '0'
                                  : _addProduct.quantityToSell?.length
                                      .toString(),
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _addProduct.addItem(_items);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddCart()));
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 5,
                      ),
                      child: Stack(
                        children: [
                          Icon(Icons.shopping_cart,
                              size: 30, color: Colors.black),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: Container(
                              width: 40,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black),
                              child: Center(
                                  child:
                                      Icon(Icons.clear, color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _items.clear();
                        _quantityToSell.clear();
                      });
                    },
                  ),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              isSearched
                  ? Expanded(
                      child: GridView.builder(
                        itemCount: _categoriesSearch.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          controller.updateValue(
                              _productPriceSearch[index].toDouble());
                          controller1.updateValue(
                              _productPackPriceSearch[index].toDouble());
                          return new Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[200],
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    _productImageSearch
                                            .asMap()
                                            .containsKey(index)
                                        ? CachedNetworkImage(
                                            width: 120,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            imageUrl:
                                                _productImageSearch[index],
                                          )
                                        : Image.asset(
                                            'assets/images/No-image.png',
                                            width: 120,
                                            height: 120,
                                            fit: BoxFit.fitWidth,
                                          ),
                                    Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          _categoriesSearch[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 2,
                                                  color: Colors.grey[200]))),
                                      child: Center(
                                        child: Text(
                                          '${_productQuantitySearch[index]} Units | ${_packQuantitySearch[index]} Packs',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.grey[800]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 2,
                                                      color:
                                                          Colors.grey[200]))),
                                          child: Center(
                                            child: Text(
                                              '${controller.text} / Units',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${controller1.text} / Pack',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                //check whether it is pack or unit
                                if (_productPackPriceSearch[index] == 0) {
                                  var map = Map();
                                  _quantityToSell.forEach((element) {
                                    if (!map.containsKey(element)) {
                                      map[element] = 1;
                                    } else {
                                      map[element] += 1;
                                    }
                                  });
                                  // when you change anything here make sure you change it in search
                                  if (map[_productIdSearch[index]] == null) {
                                    map[_productIdSearch[index]] = 0;
                                  }
                                  if (_productQuantitySearch[index] == 0 ||
                                      map[_productIdSearch[index]] -
                                              _productQuantitySearch[index] ==
                                          0) {
                                    DialogBoxes().productOutOfRange(context);
                                  } else {
                                    _quantityToSell
                                        .add(_productIdSearch[index]);
                                    _addProduct
                                        .setQuantityToSell(_quantityToSell);

                                    sellUnitProduct(
                                      _productIdSearch[index],
                                      _categoriesSearch[index],
                                      _productPriceSearch[index],
                                      _unitCostPriceSearch[index],
                                    );
                                  }
                                  print(_quantityToSell);
                                } else {
                                  // send pack to the dialog page

                                  _sellPackProduct(
                                      _packQuantitySearch[index],
                                      _productQuantitySearch[index],
                                      _productIdSearch[index],
                                      _categoriesSearch[index],
                                      _productPackPriceSearch[index],
                                      _productPriceSearch[index],
                                      _packCostPriceSearch[index]);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : StreamBuilder(
                      stream: firebaseDb,
                      builder: (context, AsyncSnapshot<Event> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.snapshot.value != null) {
                            _categories.clear();
                            _productName.clear();
                            _topCategory.clear();
                            _unitCostPrice.clear();
                            _packCostPrice.clear();
                            DataSnapshot dataValues = snapshot.data.snapshot;
                            var data = dataValues
                                .value['${_signupNotifier.firebaseId}'];
                            if (data is String) {
                              print('yes');
                            } else {
                              Map<dynamic, dynamic> values = dataValues
                                  .value['${_signupNotifier.firebaseId}'];
                              print(values);
                              values?.forEach((key, values) {
                                print(values['products']?.map((value) {
                                      _categories.add(StringUtils.capitalize(
                                          value['name']));
                                      _productId.add(value['id']);
                                      print(
                                          value['product_image']?.map((value) {
                                                _productImage
                                                    .add(value['image_link']);
                                              }) ??
                                              '[]');
                                      _barcode.add(value['bar_code']);
                                      _productQuantity.add(
                                          value['product_unit']['quantity']);
                                      print(
                                          value['product_unit']['cost_price']);
                                      _unitCostPrice.add(
                                          value['product_unit']['cost_price']);
                                      _packQuantity.add(
                                          value['product_pack']['quantity']);
                                      _productPrice
                                          .add(value['product_unit']['price']);
                                      _productPackPrice
                                          .add(value['product_pack']['price']);
                                      _packCostPrice.add(
                                          value['product_pack']['cost_price']);
                                    }) ??
                                    '[]');

                                _topCategory.add(values['name']);
                              });
                              print(_unitCostPrice);
                              print(_packCostPrice);
                              return Expanded(
                                child: GridView.builder(
                                  itemCount: _categories.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          childAspectRatio:
                                              (itemWidth / itemHeight),
                                          crossAxisCount: 2),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    controller.updateValue(
                                        _productPrice[index].toDouble());
                                    controller1.updateValue(
                                        _productPackPrice[index].toDouble());
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey[200],
                                              width: 2,
                                            ),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              _productImage
                                                      .asMap()
                                                      .containsKey(index)
                                                  ? CachedNetworkImage(
                                                      width: 120,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      imageUrl:
                                                          _productImage[index],
                                                    )
                                                  : Image.asset(
                                                      'assets/images/No-image.png',
                                                      width: 120,
                                                      height: 120,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                              Container(
                                                width: double.infinity,
                                                child: Center(
                                                  child: Text(
                                                    _categories[index],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 2,
                                                            color: Colors
                                                                .grey[200]))),
                                                child: Center(
                                                  child: Text(
                                                    '${_productQuantity[index]} Units | ${_packQuantity[index]} Packs',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color:
                                                            Colors.grey[800]),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                width: 2,
                                                                color:
                                                                    Colors.grey[
                                                                        200]))),
                                                    child: Center(
                                                      child: Text(
                                                        '${controller.text} / Units',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${controller1.text} / Pack',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          //check whether it is pack or unit
                                          if (_productPackPrice[index] == 0) {
                                            var map = Map();
                                            _quantityToSell.forEach((element) {
                                              if (!map.containsKey(element)) {
                                                map[element] = 1;
                                              } else {
                                                map[element] += 1;
                                              }
                                            });
                                            // when you change anything here make sure you change it in search
                                            if (map[_productId[index]] ==
                                                null) {
                                              map[_productId[index]] = 0;
                                            }
                                            if (_productQuantity[index] == 0 ||
                                                map[_productId[index]] -
                                                        _productQuantity[
                                                            index] ==
                                                    0) {
                                              DialogBoxes()
                                                  .productOutOfRange(context);
                                            } else {
                                              _quantityToSell
                                                  .add(_productId[index]);
                                              _addProduct.setQuantityToSell(
                                                  _quantityToSell);

                                              sellUnitProduct(
                                                _productId[index],
                                                _categories[index],
                                                _productPrice[index],
                                                _unitCostPrice[index],
                                              );
                                            }
                                            print(_productQuantity[index]);
                                            print(map[_productId[index]]);
                                          } else {
                                            // send pack to the dialog page

                                            _sellPackProduct(
                                                _packQuantity[index],
                                                _productQuantity[index],
                                                _productId[index],
                                                _categories[index],
                                                _productPackPrice[index],
                                                _productPrice[index],
                                                _packCostPrice[index]);
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Text('Add product.'),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Icon(Icons.add,
                                          size: 50, color: Colors.white)),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FormPage()));
                                },
                              )
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
            ],
          )),
    );
  }

  void search(value) {
    String capitalized = StringUtils.capitalize(value);
    _categoriesSearch.clear();
    _productPriceSearch.clear();
    _productImageSearch.clear();
    _packQuantitySearch.clear();
    _productQuantitySearch.clear();
    _productPackPriceSearch.clear();
    _productIdSearch.clear();
    _unitCostPriceSearch.clear();
    _packCostPriceSearch.clear();
    _unitCostPriceSearch.clear();
    _packCostPriceSearch.clear();

    setState(() {
      isSearched = true;
      print(_categories.map((value) {
        if (value.contains(capitalized)) {
          _categoriesSearch.add(value);
          _productPriceSearch.add(_productPrice[_categories.indexOf(value)]);
          if (_productImage.length == 0) {
            print('no Image');
          } else {
            _productImageSearch.add(_productImage[_categories.indexOf(value)]);
          }

          _packQuantitySearch.add(_packQuantity[_categories.indexOf(value)]);
          _productQuantitySearch
              .add(_productQuantity[_categories.indexOf(value)]);
          _productPackPriceSearch
              .add(_productPackPrice[_categories.indexOf(value)]);

          _unitCostPriceSearch.add(_unitCostPrice[_categories.indexOf(value)]);
          _packCostPriceSearch.add(_packCostPrice[_categories.indexOf(value)]);

          _productIdSearch.add(_productId[_categories.indexOf(value)]);
        }
        print(_categoriesSearch);
        print(_unitCostPrice.toString() + 'Cost price');
      }));
    });
  }

  void searchBarcode(value) {
    if (_barcode.contains(value)) {
      int _index = _barcode.indexWhere((element) => element == value);
      setState(() {
        _categories.removeRange(0, _index);
        _productImage.removeRange(0, _index);
        _productPrice.removeRange(0, _index);
        _packQuantity.removeRange(0, _index);
        _productQuantity.removeRange(0, _index);

        isSearched = true;
        print(_categories);
      });
    } else {
      print('does not contain value');
    }
  }

  void sellUnitProduct(
      _productId, _productName, _productUnitPrice, unitCostPrice) {
    var map = Map();
    _quantityToSell.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });

    bool _itemFound = false;
    int _index;
    for (var i = 0; i < _items.length; i++) {
      if (_items.length >= 1 && _items[i]['id'] == _productId) {
        _itemFound = true;
        _index = i;
        break;
      } else {
        print('Item Not Exists');
      }
    }
    if (_itemFound == true) {
      _items[_index]['totalQuantity'] = (map[_productId]);
      _items[_index]['totalCost'] = (map[_productId]) * _productUnitPrice;
    } else {
      _items.add({
        'totalQuantity': map[_productId],
        'type': 'unit',
        'id': _productId,
        'totalCost': _productUnitPrice * (map[_productId]),
        'name': '$_productName',
        'cost_price': unitCostPrice,
        "colours": []
      });
    }
  }

  _sellPackProduct(_packQuantity, productQuantity, _productId, _productName,
      _packPrice, _productPrice, packCostPrice) {
    bool _error = false;
    String _errorMesssage;
    AddProductToCart _addProduct =
        Provider.of<AddProductToCart>(context, listen: false);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int _productQuantity = 0;
        String _character = 'pack';

        bool _pack = true;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(_productName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          _pack
                              ? Text(_packPrice.toString())
                              : Text(_productPrice.toString())
                        ],
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, left: 80),
                          child: Stack(
                            children: [
                              Icon(Icons.shopping_cart,
                                  size: 30, color: Colors.black),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 20),
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.black),
                                  child: Center(
                                    child: Text(
                                      _addProduct.quantityToSell?.length == null
                                          ? '0'
                                          : _addProduct.quantityToSell?.length
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          // _addProduct.increment();
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Sell product as',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    child: ListTile(
                      title: const Text('Pack'),
                      leading: Radio(
                        value: 'pack',
                        groupValue: _character,
                        onChanged: (String value) {
                          setState(() {
                            _character = value;
                            _pack = true;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 40,
                    child: ListTile(
                      title: const Text('Unit'),
                      leading: Radio(
                        value: 'unit',
                        groupValue: _character,
                        onChanged: (String value) {
                          setState(() {
                            _character = value;
                            _pack = false;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (_pack == true &&
                            _packQuantity - _productQuantity <= -1)
                          return 'Pack Quantity is Higher than stock $_packQuantity';
                        else if (val.isEmpty) {
                          return 'Cannot be empty';
                        } else if (_pack == false &&
                            productQuantity - _productQuantity <= -1) {
                          return 'Unit Quantity is Higher than stock $productQuantity';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          _productQuantity = int.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7)),
                        hintText: 'Purchase Quantity',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5))),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                          child: Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Add to Cart',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              print(_packQuantity - _productQuantity);
                              print(_packQuantity);
                              bool _packFound = false;
                              bool _unitFound = false;
                              int _index;
                              int _index1;
                              if (_productQuantity > 0) {
                                for (var i = 0; i < _productQuantity; i++) {
                                  _quantityToSell.add(_productId);
                                  _addProduct
                                      .setQuantityToSell(_quantityToSell);
                                }
                                for (var i = 0; i < _items.length; i++) {
                                  if (_items.length >= 1 &&
                                      _items[i]['id'] == _productId &&
                                      _character == 'pack') {
                                    _packFound = true;
                                    _index = i;
                                    break;
                                  } else {
                                    print('pack not found');
                                  }

                                  if (_items.length >= 1 &&
                                      _items[i]['id'] == _productId &&
                                      _character == 'unit') {
                                    _unitFound = true;
                                    _index1 = i;
                                  }
                                }
                                if (_packFound == true) {
                                  _items[_index]['totalQuantity'] =
                                      _productQuantity;
                                  _items[_index]['totalCost'] =
                                      _productQuantity * _packPrice;

                                  _shoppingCartPackQuantity = _productQuantity;
                                  _addProduct.addShoppingCartPack(
                                      _shoppingCartPackQuantity);
                                } else if (_pack == true) {
                                  _items.add({
                                    'totalQuantity': _productQuantity,
                                    'type': 'pack',
                                    'id': _productId,
                                    'totalCost': _productQuantity * _packPrice,
                                    'name': '$_productName',
                                    'cost_price': packCostPrice,
                                    "colours": []
                                  });

                                  _shoppingCartPackQuantity = _productQuantity;

                                  _addProduct.addShoppingCartPack(
                                      _shoppingCartPackQuantity);
                                } else {
                                  _items.add({
                                    'totalQuantity': _productQuantity,
                                    'type': 'unit',
                                    'id': _productId,
                                    'totalCost': _productQuantity * _packPrice,
                                    'name': '$_productName',
                                    'cost_price': packCostPrice,
                                    "colours": []
                                  });

                                  _shoppingCartUnitQuantity = _productQuantity;
                                  _addProduct.addShoppingCartUnit(
                                      _shoppingCartUnitQuantity);
                                }
                                if (_unitFound == true) {
                                  _items[_index1]['totalQuantity'] =
                                      _productQuantity;
                                  _items[_index1]['totalCost'] =
                                      _productQuantity * _productPrice;
                                }
                                Navigator.pop(context);
                              }
                            }
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Checkout'),
                          ),
                        ),
                        onTap: () {
                          _addProduct.addItem(_items);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCart()));

                          // print(type);
                        },
                      )
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}

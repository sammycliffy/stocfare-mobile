import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:stockfare_mobile/notifiers/add_to_cart.dart';
import 'package:stockfare_mobile/notifiers/signup_notifier.dart';
import 'package:stockfare_mobile/screens/auth_pages/login.dart';
import 'package:stockfare_mobile/screens/intro_pages/add_single_products/form.dart';
import 'package:stockfare_mobile/screens/main_pages/activities_pages.dart';
import 'package:stockfare_mobile/screens/main_pages/all_products_list/cart.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:basic_utils/basic_utils.dart';

enum SingingCharacter { pack, unit }

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

Future<dynamic> myBackgroundHandler(Map<String, dynamic> message) {
  return _HomePageState()._showNotification(message);
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  SignupNotifier _signupNotifier;
  dynamic dataInstance;

  List _categories = [];
  List _productName = [];
  List _productPrice = [];
  List _productImage = [];
  List _productQuantity = [];
  List _packQuantity = [];
  List _productId = [];
  List _productPackPrice = [];
  bool newvalue = false;
  List<Map<String, dynamic>> items = [];
  List _items = [];
  List _quantityToSell = [];
  bool _search = false;
  int _shoppingCartPackQuantity = 0;
  int _shoppingCartUnitQuantity = 0;
  bool _addFloatingACtionButton = false;
  getTokenz() async {
    String token = await _firebaseMessaging.getToken();
    print(token);
  }

  Future selectNotification(String paload) async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future _showNotification(Map<String, dynamic> message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',
        importance: Importance.Max, priority: Priority.High);

    var platformChannelSpecifics =
        new NotificationDetails(androidPlatformChannelSpecifics, null);

    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    _firebaseMessaging.configure(
        onBackgroundMessage: myBackgroundHandler,
        onMessage: (Map<String, dynamic> message) async {
          print('onMessage: $message');
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(message['notification']['title']),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(message['notification']['body']),
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
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.6;
    final double itemWidth = size.width / 2;
    AddProductToCart _addProduct = Provider.of<AddProductToCart>(context);
    SignupNotifier _signupNotifier =
        Provider.of<SignupNotifier>(context, listen: false);

    // int val = _addProduct.listOfQuantity.reduce((a, b) => a + b);

    final dbRef = FirebaseDatabase.instance; //firebase database reference
    dbRef.setPersistenceEnabled(true);
    dbRef.setPersistenceCacheSizeBytes(10000000);
    final databaseInstance = dbRef.reference();
    databaseInstance.keepSynced(true);
    final firebaseDb = databaseInstance
        .reference()
        .child('inventories')
        .orderByKey()
        .equalTo(_signupNotifier.firebaseId);

    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Login())),
      child: Scaffold(
          floatingActionButton: _addFloatingACtionButton
              ? FloatingActionButton(
                  focusColor: Theme.of(context).canvasColor,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FormPage()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                )
              : SizedBox(),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(120.0), // here the desired height
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(color: Colors.red),
                flexibleSpace: Container(
                    child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              SizedBox(width: 100),
                              Text(
                                'Dashboard',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 110),
                              GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(),
                                  child: Stack(
                                    children: [
                                      Icon(Icons.notifications,
                                          size: 30, color: Colors.black),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ActivitiesPage()));
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              bottom: 10,
                            ),
                            child: Container(
                              height: 50,
                              width: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[200],
                              ),
                              child: TextField(
                                  onChanged: (val) {
                                    if (val.length > 0) {
                                      setState(() {
                                        searchFilter(val);
                                      });
                                    } else if (val.length <= 0) {
                                      setState(() {
                                        _search = false;
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
                                        EdgeInsets.fromLTRB(25, 10, 0, 5),
                                    hintText: 'Search Stockfare',
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                          left: 5,
                        ),
                        child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Icon(Icons.assessment,
                                    color: Colors.green, size: 40)),
                          ),
                          onTap: () {},
                        )),
                  ],
                )),
              )),
          drawer: DrawerPage(),
          body: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 18,
                      ),
                      child: InkWell(
                        child: Container(
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Text('Check out',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                        onTap: () {
                          _addProduct.addItem(_items);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCart()));
                        },
                      )),
                  GestureDetector(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 5, left: 150),
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
                                child: Text(
                                  (_quantityToSell.length +
                                          _addProduct.value +
                                          _addProduct.packValue)
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
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _search
                  ? Expanded(
                      child: GridView.builder(
                        itemCount: _categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return new Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              child: Card(
                                color: Colors.grey[100],
                                child: Column(
                                  children: <Widget>[
                                    Image.network(
                                      _productImage[index],
                                      width: 150,
                                      height: 65,
                                      fit: BoxFit.fitWidth,
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
                                          _categories[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ),
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
                                              '${_productPrice[index]}/Units',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
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
                                              '${_productPackPrice[index]}/Pack',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                if (_productPackPrice[index] == 0) {
                                  var map = Map();
                                  _quantityToSell.forEach((element) {
                                    if (!map.containsKey(element)) {
                                      map[element] = 1;
                                    } else {
                                      map[element] += 1;
                                    }
                                  }); // count the list of items
                                  print(map);
                                  print(map[_productId[index]]);
                                  if (_quantityToSell.length == 0 ||
                                      map[_productId[index]] == null) {
                                    setState(() {
                                      _quantityToSell.add(_productId[index]);
                                    });

                                    sellUnitProduct(
                                        _productId[index],
                                        _categories[index],
                                        _productPrice[index]);
                                  } else if (map[_productId[index]] >
                                      _productQuantity[index] - 1) {
                                    print(
                                        'Quantity should be less than your amount');
                                  } else {
                                    setState(() {
                                      _quantityToSell.add(_productId[index]);
                                    });

                                    sellUnitProduct(
                                        _productId[index],
                                        _categories[index],
                                        _productPrice[index]);
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
                                      _productPrice[index]);
                                }
                              },
                            ),
                          );
                        },
                      ),
                    )
                  : StreamBuilder(
                      stream: firebaseDb.onValue,
                      builder: (context, AsyncSnapshot<Event> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.snapshot.value != null) {
                            _categories.clear();
                            _productName.clear();
                            DataSnapshot dataValues = snapshot.data.snapshot;

                            Map<dynamic, dynamic> values = dataValues
                                .value['${_signupNotifier.firebaseId}'];
                            values.forEach((key, values) {
                              print(values['products']?.map((value) {
                                    _categories.add(value['name']);
                                    _productId.add(value['id']);
                                    print(value['product_image'].map((value) {
                                      _productImage.add(value['image_link']);
                                    }));

                                    _productQuantity
                                        .add(value['product_unit']['quantity']);
                                    _packQuantity
                                        .add(value['product_pack']['quantity']);
                                    _productPrice
                                        .add(value['product_unit']['price']);
                                    _productPackPrice
                                        .add(value['product_pack']['price']);
                                  }) ??
                                  '[]');
                            });

                            return Expanded(
                              child: GridView.builder(
                                itemCount: _categories.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:
                                            (itemWidth / itemHeight),
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  return new Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GestureDetector(
                                      child: Card(
                                        color: Colors.grey[100],
                                        child: Column(
                                          children: <Widget>[
                                            Image.network(
                                              _productImage[index],
                                              width: 150,
                                              height: 65,
                                              fit: BoxFit.fitWidth,
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
                                                  _categories[index],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ),
                                            ),
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
                                                              color: Colors
                                                                  .grey[200]))),
                                                  child: Center(
                                                    child: Text(
                                                      '${_productPrice[index]}/Units',
                                                      style: TextStyle(
                                                          fontSize: 12),
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
                                                      '${_productPackPrice[index]}/Pack',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        if (_productPackPrice[index] == 0) {
                                          var map = Map();
                                          _quantityToSell.forEach((element) {
                                            if (!map.containsKey(element)) {
                                              map[element] = 1;
                                            } else {
                                              map[element] += 1;
                                            }
                                          }); // count the list of items
                                          print(map);
                                          print(map[_productId[index]]);
                                          if (_quantityToSell.length == 0 ||
                                              map[_productId[index]] == null) {
                                            setState(() {
                                              _quantityToSell
                                                  .add(_productId[index]);
                                            });

                                            sellUnitProduct(
                                                _productId[index],
                                                _categories[index],
                                                _productPrice[index]);
                                          } else if (map[_productId[index]] >
                                              _productQuantity[index] - 1) {
                                            print(
                                                'Quantity should be less than your amount');
                                          } else {
                                            setState(() {
                                              _quantityToSell
                                                  .add(_productId[index]);
                                            });

                                            sellUnitProduct(
                                                _productId[index],
                                                _categories[index],
                                                _productPrice[index]);
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
                                              _productPrice[index]);
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                            );
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

  void searchFilter(value) {
    String capitalized = StringUtils.capitalize(value);
    if (_categories.contains(capitalized)) {
      print('Contains value');
      int _index = _categories.indexOf(capitalized);
      setState(() {
        _categories.removeWhere((element) => element != capitalized);
        _productImage.removeRange(0, _index);
        _productPrice.removeRange(0, _index);
        _packQuantity.removeRange(0, _index);
        _productQuantity.removeRange(0, _index);

        _search = true;
        print(_categories);
      });
    } else {
      print('does not contain value');
    }
  }

  void sellUnitProduct(_productId, _productName, _productUnitPrice) {
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
        "colours": []
      });
    }
  }

  _sellPackProduct(
    _packQuantity,
    productQuantity,
    _productId,
    _productName,
    _packPrice,
    _productPrice,
  ) {
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
                                      _quantityToSell.length.toString(),
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
                  _error
                      ? Text(
                          _errorMesssage,
                          style: TextStyle(color: Colors.red),
                        )
                      : SizedBox(),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      print(_packQuantity);
                      print(productQuantity);
                      if (_pack == true && int.parse(val) > _packQuantity) {
                        setState(() {
                          _error = true;
                          _errorMesssage = 'Pack Quantity is Higher than stock';
                        });
                      } else if (_pack == false &&
                          int.parse(val) > productQuantity) {
                        setState(() {
                          _error = true;
                          _errorMesssage = 'Unit Quantity is Higher than stock';
                        });
                      } else {
                        setState(() {
                          _productQuantity = int.parse(val);
                        });
                      }
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
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
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
                          bool _packFound = false;
                          bool _unitFound = false;
                          int _index;
                          int _index1;
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
                            _items[_index]['totalQuantity'] = _productQuantity;
                            _items[_index]['totalCost'] =
                                _productQuantity * _packPrice;

                            _shoppingCartPackQuantity = _productQuantity;
                            _addProduct
                                .addShoppingCartPack(_shoppingCartPackQuantity);
                          } else if (_pack == true) {
                            _items.add({
                              'totalQuantity': _productQuantity,
                              'type': 'pack',
                              'id': _productId,
                              'totalCost': _productQuantity * _packPrice,
                              'name': '$_productName',
                              "colours": []
                            });

                            _shoppingCartPackQuantity = _productQuantity;

                            _addProduct
                                .addShoppingCartPack(_shoppingCartPackQuantity);
                          } else {
                            _items.add({
                              'totalQuantity': _productQuantity,
                              'type': 'unit',
                              'id': _productId,
                              'totalCost': _productQuantity * _packPrice,
                              'name': '$_productName',
                              "colours": []
                            });

                            _shoppingCartUnitQuantity = _productQuantity;
                            _addProduct
                                .addShoppingCartUnit(_shoppingCartUnitQuantity);
                          }
                          if (_unitFound == true) {
                            _items[_index1]['totalQuantity'] = _productQuantity;
                            _items[_index1]['totalCost'] =
                                _productQuantity * _productPrice;
                          }
                          Navigator.pop(context);
                        },
                      ),
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
                            child: Text('Check out'),
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

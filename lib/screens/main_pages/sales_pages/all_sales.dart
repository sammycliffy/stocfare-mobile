import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stockfare_mobile/models/sales_model.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/bottom_navigation.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/dialog_boxes.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/sales_pages/receipt.dart';
import 'package:stockfare_mobile/services/activities_services.dart';
import 'package:stockfare_mobile/services/sales_services.dart';

class AllSalesList extends StatefulWidget {
  const AllSalesList({Key key}) : super(key: key);
  @override
  _AllSalesListState createState() => _AllSalesListState();
}

class _AllSalesListState extends State<AllSalesList> {
  SalesServices _salesServices = SalesServices();
  ActivitiesServices _activitiesServices = ActivitiesServices();
  Future<GetSalesModel> salesList;
  Future<GetSalesModel> sortedList;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = new ScrollController();
  bool _error = false;
  bool isNetwork = true;
  String _errorMessage;
  bool _sortedDate = false;
  bool _searchSales = false;
  dynamic selectedDate = DateTime.now();
  List names = [];
  List _productNames = [];
  List customerNames = [];
  List sellerNames = [];
  List dateCreated = [];
  List salesId = [];
  int pageNumber = 1;
  bool isLoading = false;
  List price = [];
  List amountSold = [];
  List quantitySold = [];
  List customerChange = [];
  List referenceCode = [];
  List tax = [];
  List soldOnCredit = [];
  List amountPaid = [];
  List totalAmount = [];
  dynamic next;
  int realNumber = 2;

  @override
  initState() {
    _clear();
    super.initState();
    _loadSales();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage())),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerPage(),
        appBar: AppBar(
          title: Text('Sales History'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Container(
                        height: 45,
                        width: 300,
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
                                  _searchSales = false;
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
                              contentPadding: EdgeInsets.fromLTRB(25, 8, 0, 5),
                              hintText: 'Search Stockfare',
                            )),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        body: (() {
          if (isNetwork == false) {
            return GestureDetector(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    Icon(
                      Icons.mood_bad,
                      size: 40,
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'An error occured',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {},
            );
          } else if (_error == true) {
            return Center(
              child: Text(
                _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (_sortedDate == true) {
            return Column(
              children: [
                SizedBox(height: 20),
                GestureDetector(
                  child: Center(
                      child: Container(
                    width: 150,
                    height: 40,
                    color: Colors.black,
                    child: Center(
                        child: Text('All Sales',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  )),
                  onTap: () {
                    setState(() {
                      _sortedDate = false;
                      _searchSales = false;
                    });
                    _loadSales();
                  },
                ),
                Expanded(
                  child: _listView(),
                )
              ],
            );
          } else if (isLoading == true) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _listView();
          }
        }()),
      ),
    );
  }

  Future<void> _confirmDelete(
    context,
    index,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Text(
                'Confirm Delete',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Are you sure you want to delete this Sale?',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          )),
          actions: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                    child: Center(
                        child: Text(
                      'No',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 18),
                    )),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    child: Center(
                      child: Container(
                        height: 30,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      DialogBoxes().loading(context);
                      dynamic result = await _salesServices
                          .deleteSales(salesId[index])
                          .timeout(Duration(seconds: 10),
                              onTimeout: () => null);
                      if (result != 204) {
                        Navigator.pop(_scaffoldKey.currentContext);

                        setState(() {
                          result == null
                              ? _errorMessage =
                                  'Opps! Error occured, please try again.'
                              : _errorMessage = result.toString();
                          _displaySnackBar(_scaffoldKey.currentContext);
                        });
                      } else {
                        Navigator.pop(_scaffoldKey.currentContext);

                        _salesServices.getallSales().then((value) {
                          setState(() {
                            _clear();
                            print(value.results?.map((value) {
                                  salesId.add(value.id);
                                  realNumber = 2;
                                  if (value.customer == null) {
                                    customerNames.add('None');
                                  } else {
                                    customerNames.add(value.customer.name);
                                  }
                                  _productNames.add(value.productDetail);
                                  tax.add(value.tax);
                                  amountSold.add(value.amount);
                                  referenceCode.add(value.refCode);
                                  customerChange.add(value.change);
                                  amountPaid.add(value.amountPaid);
                                  sellerNames.add(value.saleRegisteredBy);
                                  names.add(value.productData[0].name);
                                  soldOnCredit.add(value.soldOnCredit);
                                  print(value.productData.map((value) {
                                    dateCreated.add(value.dateCreated);
                                  }));
                                }) ??
                                '[]');
                          });
                        });
                      }
                    }),
              ],
            )
          ],
        );
      },
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          _error.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void searchFilter(value) {
    String capitalized = StringUtils.capitalize(value);
    int _index = names.indexWhere((element) => element.startsWith(capitalized));
    print(_index);
    if (_index != -1) {
      print('Contains value');
      String item = names[_index];
      setState(() {
        names.removeWhere((element) => element != item);
        sellerNames.removeRange(0, _index);
        customerNames.removeRange(0, _index);
        salesId.removeRange(0, _index);
        _searchSales = true;
        _sortedDate = false;
      });
    } else {
      print('does not contain value');
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        _sortedDate = true;
        _searchSales = false;
      });
      sortedList = _salesServices
          .sortedDates((picked.toUtc().millisecondsSinceEpoch / 1000).round());
      print(sortedList.then((value) {
        if (value.count == 0) {
          print('no sales');
        }
        _clear();
        setState(() {
          print(value.results?.map((value) {
                salesId.add(value.id);
                if (value.customer == null) {
                  customerNames.add('None');
                } else {
                  customerNames.add(value.customer.name);
                }
                _productNames.add(value.productDetail);
                tax.add(value.tax);
                amountSold.add(value.amount);
                referenceCode.add(value.refCode);
                customerChange.add(value.change);
                amountPaid.add(value.amountPaid);
                sellerNames.add(value.saleRegisteredBy);
                names.add(value.productData[0].name);
                soldOnCredit.add(value.soldOnCredit);
                print(value.productData.map((value) {
                  dateCreated.add(value.dateCreated);
                }));
              }) ??
              '[]');
        });
      }));
    }
  }

  _listView() {
    return Column(
      children: [
        SizedBox(height: 20),
        GestureDetector(
          child: Container(
            width: 200,
            height: 40,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sort Sales with date'),
                SizedBox(width: 20),
                Icon(Icons.date_range)
              ],
            ),
          ),
          onTap: () => _selectDate(context),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                setState(() {
                  realNumber = realNumber + 1;
                });
                _loadData();
              }
            },
            child: (() {
              if (names.length == 0) {
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
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Card(
                          child: ListTile(
                            leading:
                                Icon(Icons.monetization_on, color: Colors.grey),
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
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        'Buyer :  ${customerNames[index].toString()}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: 'FireSans'),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        'Seller :  ${sellerNames[index].toString()}',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: 'FireSans'),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: Text(
                                        'Date :  ${Jiffy(dateCreated[index]).fromNow()}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'FireSans'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _confirmDelete(context, index);
                                }),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProductsList(
                                        customerIndex: index,
                                        names: _productNames,
                                        customerNames: customerNames,
                                        sellerNames: sellerNames,
                                        dateCreated: dateCreated,
                                        price: price,
                                        amountSold: amountSold,
                                        quantitySold: quantitySold,
                                        customerChange: customerChange,
                                        referenceCode: referenceCode,
                                        tax: tax,
                                        soldOnCredit: soldOnCredit,
                                        amountPaid: amountPaid,
                                      )));
                        },
                      );
                    });
              }
            }()),
          ),
        ),
      ],
    );
  }

  _clear() {
    names.clear();
    _productNames.clear();
    customerNames.clear();
    sellerNames.clear();
    dateCreated.clear();
    salesId.clear();
    price.clear();
    amountSold.clear();
    quantitySold.clear();
    customerChange.clear();
    referenceCode.clear();
    tax.clear();
    soldOnCredit.clear();
    amountPaid.clear();
    totalAmount.clear();
  }

  Future _loadData() async {
    _salesServices.getSalesPages(realNumber).then((value) {
      setState(() {
        print(value.results?.map((value) {
              salesId.add(value.id);
              if (value.customer == null) {
                customerNames.add('None');
              } else {
                customerNames.add(value.customer.name);
              }
              _productNames.add(value.productDetail);
              tax.add(value.tax);
              amountSold.add(value.amount);
              referenceCode.add(value.refCode);
              customerChange.add(value.change);
              amountPaid.add(value.amountPaid);
              sellerNames.add(value.saleRegisteredBy);
              names.add(value.productData[0].name);
              print(value.productData[0].name);
              soldOnCredit.add(value.soldOnCredit);
              print(value.productData.map((value) {
                dateCreated.add(value.dateCreated);
              }));
            }) ??
            '[]');
      });
    });
  }

  _loadSales() {
    _activitiesServices.checkForInternet().then((value) {
      if (value == true) {
        setState(() {
          isLoading = true;
        });
        _salesServices.getallSales().then((value) {
          setState(() {
            print(value?.results?.map((value) {
                  salesId.add(value.id);
                  if (value.customer == null) {
                    customerNames.add('None');
                  } else {
                    customerNames.add(value.customer.name);
                  }
                  _productNames.add(value.productDetail);

                  tax.add(value.tax);
                  amountSold.add(value.amount);
                  referenceCode.add(value.refCode);
                  customerChange.add(value.change);
                  amountPaid.add(value.amountPaid);
                  sellerNames.add(value.saleRegisteredBy);
                  names.add(value.productData[0].name);
                  soldOnCredit.add(value.soldOnCredit);
                  print(value.productData.map((value) {
                    dateCreated.add(value.dateCreated);
                  }));
                }) ??
                '[]' ??
                '[]');
          });
        }).whenComplete(() {
          setState(() {
            isLoading = false;
          });
        }).catchError((e) {
          setState(() {
            _error = true;
            _errorMessage = e.toString();
          });
        });
      } else {
        setState(() {
          isNetwork = false;
        });
      }
    });
  }
}

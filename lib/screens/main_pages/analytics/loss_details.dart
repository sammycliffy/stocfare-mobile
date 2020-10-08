import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stockfare_mobile/models/loss_model.dart';

class LossDetails extends StatefulWidget {
  final List<LossModel> profitList;
  final int productIndex;
  LossDetails({
    Key key,
    @required this.profitList,
    @required this.productIndex,
  }) : super(key: key);
  @override
  _ProfitDetailsState createState() => _ProfitDetailsState();
}

class _ProfitDetailsState extends State<LossDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Profit Details'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                'REF:  ${widget.profitList[widget.productIndex].salesLossId.refCode}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                Jiffy(widget.profitList[widget.productIndex].salesLossId
                        .dateCreated)
                    .yMMMMEEEEdjm,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      'ITEMS',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      'PRICE',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      for (var name in widget.profitList[widget.productIndex]
                          .salesLossId.productDetail)
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: Text(
                            name.name.toString() +
                                ' ' +
                                name.quantityBought.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      for (var cost in widget.profitList[widget.productIndex]
                          .salesLossId.productDetail)
                        Padding(
                          padding: const EdgeInsets.only(right: 30, top: 10),
                          child: Text(
                            cost.totalCost.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      'Customer',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      "None",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      'Change',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      widget.profitList[widget.productIndex].salesLossId.change,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      'Seller',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      widget.profitList[widget.productIndex].salesLossId
                          .saleRegisteredBy,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      'Sold on Credit',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      widget.profitList[widget.productIndex].salesLossId
                          .soldOnCredit
                          .toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 10),
                    child: Text(
                      'Amount Paid',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10),
                    child: Text(
                      widget.profitList[widget.productIndex].salesLossId.amount,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 120,
                  width: 350,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              'VAT',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Sora',
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, top: 10),
                            child: Text(
                              widget.profitList[widget.productIndex].salesLossId
                                  .tax,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Sora',
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              'YOU OWE',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Sora',
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, top: 5),
                            child: Text(
                              widget.profitList[widget.productIndex].salesLossId
                                  .change
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Sora',
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 10),
                            child: Text(
                              'TOTAL',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Sora',
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30, top: 5),
                            child: Text(
                              widget.profitList[widget.productIndex].salesLossId
                                  .amount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Sora',
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: 60)
            ],
          ),
        ));
  }
}

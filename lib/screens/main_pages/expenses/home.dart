import 'package:flutter/material.dart';
import 'package:stockfare_mobile/screens/main_pages/common_widget/drawer.dart';
import 'package:stockfare_mobile/screens/main_pages/expenses/expenses.dart';

import 'income.dart';

class ExpensesHome extends StatefulWidget {
  @override
  _ExpensesHomeState createState() => _ExpensesHomeState();
}

class _ExpensesHomeState extends State<ExpensesHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Expenses',
              ),
              Tab(text: 'Income')
            ],
          ),
          title: Text('Expenses & Income'),
        ),
        body: TabBarView(
          children: [
            ExpensesHomePage(),
            IncomeHomePage(),
          ],
        ),
      ),
    );
  }
}

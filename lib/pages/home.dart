import 'package:flutter/material.dart';
import 'package:itms_flutter/pages/Sales/invoices.dart';
import 'package:itms_flutter/pages/Sales/sale_history.dart';
import 'package:itms_flutter/pages/categories/categories.dart';
import 'package:itms_flutter/pages/products/products.dart';
import 'package:itms_flutter/pages/services/services.dart';

import 'customers/customers.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _title = 'Müşteriler';
  Widget _page = Customers();
  String _route = '/add_customer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        actions: [
          //Add new data
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () {
              Navigator.pushNamed(context, _route);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            //Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Business icon
                  Icon(
                    Icons.business,
                    size: 100,
                  ),
                  //Business name
                  Text(
                    'Pazarlama Yönetimi',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            //Categories
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text(
                'Kategoriler',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                setState(() {
                  _title = 'Kategoriler';
                  _page = Categories();
                  _route = '/add_category';
                });
                Navigator.of(context).pop();
              },
            ),
            //Customers
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text(
                'Müşteriler',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                setState(() {
                  _title = 'Müşteriler';
                  _page = Customers();
                  _route = '/add_customer';
                });
                Navigator.of(context).pop();
              },
            ),
            //Products
            ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text(
                'Ürünler',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                setState(() {
                  _title = 'Ürünler';
                  _page = Products();
                  _route = '/add_product';
                });
                Navigator.of(context).pop();
              },
            ),
            //Services
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text(
                'Hizmetler',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                setState(() {
                  _title = 'Hizmetler';
                  _page = Services();
                  _route = '/add_service';
                });
                Navigator.of(context).pop();
              },
            ),
            //Sales
            ExpansionTile(
              leading: const Icon(Icons.payments),
              title: const Text(
                'Satışlar',
                style: TextStyle(fontSize: 20),
              ),
              children: [
                //Sale History
                ListTile(
                  leading: const Icon(Icons.timeline),
                  title: const Text(
                    'Satış Geçmişi',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    setState(() {
                      _title = 'Satış Geçmişi';
                      _page = SaleHistory();
                      _route = '/add_sale';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                //Invoice
                ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text(
                    'Faturalar',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    setState(() {
                      _title = 'Faturalar';
                      _page = Invoices();
                      _route = '/add_invoice';
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: _page,
    );
  }
}

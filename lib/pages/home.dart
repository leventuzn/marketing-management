import 'package:flutter/material.dart';
import 'package:itms_flutter/pages/categories/categories.dart';
import 'package:itms_flutter/pages/products/products.dart';
import 'package:itms_flutter/pages/sales/sales.dart';
import 'package:itms_flutter/pages/services/services.dart';
import 'customers/customers.dart';
import 'visits/visits.dart';

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
              leading: const Icon(
                Icons.category,
                color: Colors.black,
              ),
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
              leading: const Icon(
                Icons.people,
                color: Colors.black,
              ),
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
              leading: const Icon(
                Icons.storefront,
                color: Colors.black,
              ),
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
              leading: const Icon(
                Icons.support_agent,
                color: Colors.black,
              ),
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
            ListTile(
              leading: const Icon(
                Icons.payment,
                color: Colors.black,
              ),
              title: const Text(
                'Satışlar',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                setState(() {
                  _title = 'Satışlar';
                  _page = Sales();
                  _route = '/add_sale';
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.screen_search_desktop_outlined,
                color: Colors.black,
              ),
              title: const Text(
                'Ziyaretler',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                setState(() {
                  _title = 'Ziyaretler';
                  _page = Visits();
                  _route = '/add_visit';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: _page,
    );
  }
}

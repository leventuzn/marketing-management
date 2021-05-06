import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<String> manuItems = <String>[
    'Categories',
    'Customers',
    'Products',
    'Services',
    'Sales',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
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
                    color: Colors.white,
                    size: 100,
                  ),
                  //Business name
                  Text(
                    'ITMS Company',
                    style: TextStyle(
                      color: Colors.white,
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
                'Categories',
                style: TextStyle(fontSize: 20),
              ),
            ),
            //Customers
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text(
                'Customers',
                style: TextStyle(fontSize: 20),
              ),
            ),
            //Products
            ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text(
                'Products',
                style: TextStyle(fontSize: 20),
              ),
            ),
            //Services
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text(
                'Services',
                style: TextStyle(fontSize: 20),
              ),
            ),
            //Sales
            ExpansionTile(
              leading: const Icon(Icons.payments),
              title: const Text(
                'Sales',
                style: TextStyle(fontSize: 20),
              ),
              children: [
                //Sale History
                ListTile(
                  leading: const Icon(Icons.timeline),
                  title: const Text(
                    'Sale History',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                //Invoice
                ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: const Text(
                    'Invoice',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(),
      ),
    );
  }
}

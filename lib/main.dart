import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/pages/customers/add_customer.dart';
import 'package:itms_flutter/pages/customers/update_customer.dart';
import 'package:itms_flutter/pages/home.dart';
import 'package:itms_flutter/pages/login.dart';
import 'package:itms_flutter/pages/sales/add_sale_item.dart';
import 'package:itms_flutter/pages/services/add_service.dart';
import 'package:itms_flutter/pages/sign_up.dart';
import 'pages/categories/add_category.dart';
import 'pages/categories/update_category.dart';
import 'pages/products/add_product.dart';
import 'pages/products/update_product.dart';
import 'pages/sales/add_sale.dart';
import 'pages/sales/sale_items.dart';
import 'pages/services/update_service.dart';
import 'pages/visits/add_visit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }

        return MaterialApp(
          title: 'Itms',
          theme: ThemeData(
            primaryColor: Colors.grey[300],
            primarySwatch: Colors.blue,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.black,
              textTheme: ButtonTextTheme.primary,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomePage(),
            '/sign_up': (context) => SignUpPage(),
            '/add_customer': (context) => AddCustomer(),
            '/add_product': (context) => AddProduct(),
            '/add_service': (context) => AddService(),
            '/add_category': (context) => AddCategory(),
            '/add_sale': (context) => AddSale(),
            '/add_sale_item': (context) => AddSaleItem(),
            '/update_customer': (context) => UpdateCustomer(),
            '/update_category': (context) => UpdateCategory(),
            '/update_product': (context) => UpdateProduct(),
            '/update_service': (context) => UpdateService(),
            '/sale_items': (context) => SaleItems(),
            '/add_visit': (context) => AddVisit(),
          },
        );
      },
    );
  }
}

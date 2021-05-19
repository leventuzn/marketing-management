import 'package:flutter/material.dart';
import 'package:itms_flutter/pages/customers/add_customer.dart';
import 'package:itms_flutter/pages/customers/update_customer.dart';
import 'package:itms_flutter/pages/home.dart';
import 'package:itms_flutter/pages/login.dart';
import 'package:itms_flutter/pages/sign_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itms',
      theme: ThemeData(
        primaryColor: Colors.grey[300],
        primarySwatch: Colors.blue,
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
        '/update_customer': (context) => UpdateCustomer(),
        /*'/add_product' : (context) => AddProduct(),
        '/add_sale': (context) => AddSale(),
        '/add_service': (context) => AddService(),
        '/add_category': (context) => AddCategory(),*/
      },
    );
  }
}

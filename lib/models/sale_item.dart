import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SaleItem {
  String name;
  String amount;
  String price;
  String type;

  SaleItem();

  SaleItem.fromSaleItem(this.name, this.amount, this.price, this.type);
}

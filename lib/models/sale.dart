import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Sale {
  CollectionReference saleItems;
  String customerId;
  Timestamp date;
  String totalPrice;

  Sale();

  Sale.fromSale(this.saleItems, this.customerId, this.date, this.totalPrice);
}

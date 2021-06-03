import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Product {
  String name;
  String description;
  String price;
  DocumentReference category;

  Product();

  Product.fromProduct(this.name, this.description, this.price, this.category);
}

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Service {
  String name;
  String description;
  String price;
  DocumentReference category;

  Service();

  Service.fromService(this.name, this.description, this.price, this.category);
}

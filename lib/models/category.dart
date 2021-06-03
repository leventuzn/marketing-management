import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Category {
  String name;
  //String type;

  Category();

  Category.fromCategory(
    this.name,
    /*this.type*/
  );
}

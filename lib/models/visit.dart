import 'package:cloud_firestore/cloud_firestore.dart';

class Visit {
  String customer;
  String name;
  Timestamp date;

  Visit();

  Visit.fromVisits(this.customer, this.name, this.date);
}

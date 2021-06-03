import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Customer {
  String firstName;
  String lastName;
  String phone;
  String email;
  String address;
  String identity;

  Customer();

  Customer.fromCustomer(this.firstName, this.lastName, this.phone, this.email,
      this.address, this.identity);
}

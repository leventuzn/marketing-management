import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Customers extends StatefulWidget {
  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  Widget _listItem(String firstname, String lastname, String phone,
      String email, String id) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Card(
        elevation: 1.5,
        margin: EdgeInsets.fromLTRB(6, 12, 6, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/update_customer', arguments: id);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor:
                      Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                  child: Text(
                    (firstname.substring(0, 1) + lastname.substring(0, 1))
                        .toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(firstname + ' ' + lastname),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              phone,
                              maxLines: 1,
                              stepGranularity: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Icon(Icons.email),
                          Flexible(
                            flex: 1,
                            child: AutoSizeText(
                              email,
                              maxLines: 1,
                              stepGranularity: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteCustomer(id);
                  },
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteCustomer(String id) {
    return customers
        .doc(id)
        .delete()
        .then((value) => print("Customer deleted"))
        .catchError((error) => print("Failed to delete Customer: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: customers.orderBy('firstname').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return _listItem(
              document.get('firstname'),
              document.get('lastname'),
              document.get('phone'),
              document.get('email'),
              document.id,
            );
          }).toList(),
        );
      },
    );
  }
}

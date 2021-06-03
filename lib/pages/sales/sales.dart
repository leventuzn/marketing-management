import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  final CollectionReference sales =
      FirebaseFirestore.instance.collection('sales');
  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  final dateFormat = new DateFormat('yyyy-MM-dd HH:mm');
  Widget _listItem(
      String customerId, Timestamp date, String totalPrice, String id) {
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
            Navigator.pushNamed(context, '/sale_items', arguments: id);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customerId),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Row(
                        children: [
                          Icon(Icons.calendar_today),
                          Text(dateFormat.format(date.toDate()).toString()),
                          Padding(padding: EdgeInsets.only(left: 8)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Text(totalPrice)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: sales.orderBy('date').snapshots(),
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
              document.get('customerId'),
              document.get('date'),
              document.get('totalPrice'),
              document.id,
            );
          }).toList(),
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Visits extends StatefulWidget {
  @override
  _Visits createState() => _Visits();
}

class _Visits extends State<Visits> {
  final CollectionReference visits =
      FirebaseFirestore.instance.collection('visits');
  final dateFormat = new DateFormat('yyyy-MM-dd HH:mm');

  Widget _listItem(String customer, String name, Timestamp date, String id) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Card(
            elevation: 1.5,
            margin: EdgeInsets.fromLTRB(6, 12, 6, 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: InkWell(
              onTap: () {},
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
                        Text(name),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        Row(
                          children: [
                            Icon(Icons.person),
                            Text(customer),
                            Padding(padding: EdgeInsets.only(left: 8)),
                            Icon(Icons.calendar_today),
                            Text(dateFormat.format(date.toDate()).toString())
                          ],
                        ),
                      ],
                    )),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: visits.orderBy('name').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          if (!snapshot.hasData) {
            return Text('Ziyaret geçmişi bulaunamadı');
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return _listItem(
                document.get('customer'),
                document.get('name'),
                document.get('date'),
                document.id,
              );
            }).toList(),
          );
        });
  }
}

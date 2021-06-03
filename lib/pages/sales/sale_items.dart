import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SaleItems extends StatefulWidget {
  @override
  _SaleItemsState createState() => _SaleItemsState();
}

class _SaleItemsState extends State<SaleItems> {
  Widget _listItem(String name, String amount, String price, String type) {
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
            //Navigator.pushNamed(context, '/sale_items', arguments: id);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    child: type == '1'
                        ? Icon(Icons.storefront)
                        : Icon(Icons.support_agent)),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Row(
                        children: [
                          Icon(Icons.toll),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Text(amount),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                Text(price)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    final CollectionReference saleItems = FirebaseFirestore.instance
        .collection('sales')
        .doc(args.toString())
        .collection('saleItems');

    return Scaffold(
      appBar: AppBar(
        title: Text('Satış Geçmişi'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: saleItems.snapshots(),
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
                document.get('name'),
                document.get('amount'),
                document.get('price'),
                document.get('type'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

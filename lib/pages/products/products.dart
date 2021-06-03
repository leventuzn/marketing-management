import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Widget _listItem(String name, String description, String price,
      String categoryName, String id) {
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
            Navigator.pushNamed(context, '/update_product', arguments: id);
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
                      Text(name),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Row(
                        children: [
                          Icon(Icons.description),
                          Text(description),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Icon(Icons.email),
                          Text(price),
                        ],
                      ),
                      Text(categoryName)
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteProduct(id);
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

  Future<void> deleteProduct(String id) {
    return products
        .doc(id)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: products.orderBy('name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return FutureBuilder(
              future: document.get('category').get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading');
                }

                return _listItem(
                  document.get('name'),
                  document.get('description'),
                  document.get('price'),
                  snapshot.data['name'],
                  document.id,
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

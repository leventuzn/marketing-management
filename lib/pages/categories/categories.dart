import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Widget _listItem(String name, /*String type,*/ String id) {
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
            Navigator.pushNamed(context, '/update_category', arguments: id);
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
                    (name.substring(0, 2)).toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      //Text(type),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 8)),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteCategory(id);
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

  Future<void> deleteCategory(String id) {
    return categories
        .doc(id)
        .delete()
        .then((value) => print("Category deleted"))
        .catchError((error) => print("Failed to delete Category: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: categories.orderBy('name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        if (!snapshot.hasData) {
          return Text("Kay??t yok");
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return _listItem(
              document.get('name'),
              //document.data['type'],
              document.id,
            );
          }).toList(),
        );
      },
    );
  }
}

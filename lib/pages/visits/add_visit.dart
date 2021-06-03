import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/models/visit.dart';

class AddVisit extends StatefulWidget {
  @override
  _AddVisitState createState() => _AddVisitState();
}

class _AddVisitState extends State<AddVisit> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference services =
      FirebaseFirestore.instance.collection('services');
  CollectionReference visits = FirebaseFirestore.instance.collection('visits');
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  String _customer, _email;
  String _name, _item;
  Color _color1 = Colors.black;
  Color _color2 = Colors.grey;

  String _type;
  void initState() {
    super.initState();
    _type = '1';
  }

  @override
  Widget build(BuildContext context) {
    final Visit visit = new Visit();
    Future<void> addVisit() {
      return visits
          .add({
            'customer': visit.customer,
            'name': visit.name,
            'date': visit.date,
          })
          .then((value) => print('Visit Added'))
          .catchError((error) => print("Failed to add visit: $error"));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Ziyaretçi Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: .5,
              child: FutureBuilder(
                future: customers.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return DropdownButton(
                          menuMaxHeight: 300,
                          isExpanded: true,
                          value: _customer,
                          items: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return DropdownMenuItem(
                                onTap: () {
                                  _email = document.get('email');
                                },
                                value: document.id,
                                child: Text(document.get('email')));
                          }).toList(),
                          onChanged: (changedValue) {
                            setState(() {
                              _customer = changedValue;
                            });
                          });
                    },
                  );
                },
              ),
            ),
            FractionallySizedBox(
              widthFactor: .5,
              child: FutureBuilder(
                future: _type == '1'
                    ? products.orderBy('name').get()
                    : services.orderBy('name').get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(" ");
                  }
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return DropdownButton(
                          menuMaxHeight: 300,
                          isExpanded: true,
                          value: _item,
                          items: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return DropdownMenuItem(
                                onTap: () {
                                  _name = document.get('name');
                                },
                                value: document.id,
                                child: Text(document.get('name')));
                          }).toList(),
                          onChanged: (changedValue) {
                            setState(() {
                              _item = changedValue;
                            });
                          });
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      child: Text('Ürün'),
                      style: ElevatedButton.styleFrom(primary: _color1),
                      onPressed: () {
                        setState(() {
                          _type = '1';
                          _color1 = Colors.black;
                          _color2 = Colors.grey;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ElevatedButton(
                      child: Text('Hizmet'),
                      style: ElevatedButton.styleFrom(primary: _color2),
                      onPressed: () {
                        setState(() {
                          _type = '2';
                          _color2 = Colors.black;
                          _color1 = Colors.grey;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () {
          visit.customer = _email;
          visit.name = _name;
          visit.date = Timestamp.now();
          if (_formKey.currentState.validate()) {
            addVisit();
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}

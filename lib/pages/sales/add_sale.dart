import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/models/sale.dart';
import 'package:itms_flutter/models/screen_arguments.dart';

class AddSale extends StatefulWidget {
  @override
  _AddSaleState createState() => _AddSaleState();
}

class _AddSaleState extends State<AddSale> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference services =
      FirebaseFirestore.instance.collection('services');
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference sales = FirebaseFirestore.instance.collection('sales');
  CollectionReference cartItems =
      FirebaseFirestore.instance.collection('cartItems');
  CollectionReference saleItems =
      FirebaseFirestore.instance.collection('saleItems');
  String _selectedCustomer;
  String _totalPrice;
  String _saleId;
  TextEditingController _amountController = TextEditingController();

  void initState() {
    super.initState();
    _amountController.text = '0';
    _totalPrice = '0';
    _saleId = sales.doc().id;
  }

  @override
  Widget build(BuildContext context) {
    final Sale sale = new Sale();

    Future<void> addSale() {
      return sales
          .doc(_saleId)
          .set({
            'customerId': sale.customerId,
            'totalPrice': sale.totalPrice,
            'date': sale.date,
          })
          .then((value) => print('Sale Added'))
          .catchError((error) => print("Failed to add sale: $error"));
    }

    _showFormDialog(BuildContext context) {
      return showDialog(
          context: context,
          // ekrana tiklandiginda alerti dismiss etmek icin true veriyoruz ozellige
          barrierDismissible: true,
          builder: (param) {
            return AlertDialog(
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    addSale();
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
                  },
                  child: Text('Save'),
                ),
              ],
              title: Text('New Sale'),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                      future: customers.get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return DropdownButton(
                                value: _selectedCustomer,
                                items: snapshot.data.docs
                                    .map((DocumentSnapshot document) {
                                  return DropdownMenuItem(
                                      onTap: () {},
                                      value: document.id,
                                      child: Text(document.get('email')));
                                }).toList(),
                                onChanged: (changedValue) {
                                  setState(() {
                                    _selectedCustomer = changedValue;
                                    sale.customerId = _selectedCustomer;
                                  });
                                });
                          },
                        );
                      },
                    ),
                    Text('Total Price: ' + sale.totalPrice)
                  ],
                ),
              ),
            );
          });
    }

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
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Ürün veya Hizmet Ekle'),
        actions: [
          //Add sale items
          IconButton(
            icon: Icon(Icons.add),
            iconSize: 30,
            onPressed: () async {
              var result = await Navigator.pushNamed(context, '/add_sale_item',
                  arguments: ScreenArguments(int.parse(_totalPrice), _saleId));
              _totalPrice = result;
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: sales.doc(_saleId).collection('saleItems').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('No items yet');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(" ");
            }
            return new ListView(
              children: snapshot.data.docs.map<Widget>((document) {
                return _listItem(
                  document.get('name'),
                  document.get('amount'),
                  document.get('price'),
                  document.get('type'),
                );
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {
          sale.customerId = _selectedCustomer;
          sale.date = Timestamp.now();
          sale.totalPrice = _totalPrice.toString();
          _showFormDialog(context);
        },
      ),
    );
  }
}

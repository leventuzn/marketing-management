import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/models/sale_item.dart';
import 'package:itms_flutter/models/screen_arguments.dart';

class AddSaleItem extends StatefulWidget {
  @override
  _AddSaleItemState createState() => _AddSaleItemState();
}

class _AddSaleItemState extends State<AddSaleItem> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference services =
      FirebaseFirestore.instance.collection('services');
  CollectionReference sales = FirebaseFirestore.instance.collection('sales');
  CollectionReference saleItems =
      FirebaseFirestore.instance.collection('saleItems');
  String _selectedItem;
  String _selectedName;
  Color _color1 = Colors.black;
  Color _color2 = Colors.grey;
  int itemPrice;
  int totalPrice;
  TextEditingController _amountController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String _type;
  void initState() {
    super.initState();
    _type = '1';
    _amountController.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    final SaleItem saleItem = new SaleItem();
    var args = ModalRoute.of(context).settings.arguments;
    ScreenArguments arguments = args;
    Future<void> addSaleItem() {
      return sales
          .doc(arguments.saleId)
          .collection('saleItems')
          .add({
            'name': saleItem.name,
            'amount': saleItem.amount,
            'price': saleItem.price,
            'type': saleItem.type,
          })
          .then((value) => print('SaleItem Added'))
          .catchError((error) => print("Failed to add saleItem: $error"));
    }

    Function _validator = (value) {
      if (value == null || value.isEmpty) {
        return 'Bu alan boş bırakılamaz';
      }
      return null;
    };

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Ürün veya Hizmet Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                          value: _selectedItem,
                          items: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return DropdownMenuItem(
                                onTap: () {
                                  _selectedName = document.get('name');
                                  itemPrice = int.parse(document.get('price'));
                                },
                                value: document.id,
                                child: Text(document.get('name')));
                          }).toList(),
                          onChanged: (changedValue) {
                            setState(() {
                              _selectedItem = changedValue;
                            });
                          });
                    },
                  );
                },
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.toll),
                hintText: 'Miktar',
                labelText: 'Miktar *',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              validator: _validator,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _priceController.text =
                      (int.parse(value) * itemPrice).toString();
                } else {
                  _priceController.text = '0';
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: 'Fiyatı',
                labelText: 'Fiyatı',
              ),
              controller: _priceController,
              enabled: false,
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
          saleItem.name = _selectedName;
          saleItem.amount = _amountController.text;
          saleItem.price = _priceController.text;
          saleItem.type = _type;
          if (_formKey.currentState.validate()) {
            arguments.totalPrice += int.parse(saleItem.price);
            addSaleItem();
            Navigator.pop(context, arguments.totalPrice.toString());
          }
        },
      ),
    );
  }
}

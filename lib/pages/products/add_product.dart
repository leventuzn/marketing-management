import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/models/product.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  String _selectedItem;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    final Product product = new Product();
    Future<void> addProduct() {
      return products
          .add({
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'category': product.category,
          })
          .then((value) => print('Product Added'))
          .catchError((error) => print("Failed to add product: $error"));
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
        title: Text('Ürün Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.info),
                hintText: 'Adı',
                labelText: 'Adı *',
              ),
              controller: _nameController,
              keyboardType: TextInputType.text,
              validator: _validator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'Açıklama',
                labelText: 'Açıklama *',
              ),
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              maxLength: 250,
              maxLines: 3,
              validator: _validator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: 'Fiyatı',
                labelText: 'Fiyatı *',
              ),
              controller: _priceController,
              keyboardType: TextInputType.number,
              validator: _validator,
            ),
            FutureBuilder(
              future: categories.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(" ");
                }
                return StatefulBuilder(
                  builder: (context, setState) {
                    return DropdownButton(
                        isExpanded: true,
                        menuMaxHeight: 300,
                        value: _selectedItem,
                        items:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          return DropdownMenuItem(
                              onTap: () {},
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
            ElevatedButton.icon(
              onPressed: () {
                product.name = _nameController.text;
                product.description = _descriptionController.text;
                product.price = _priceController.text;
                product.category = categories.doc(_selectedItem);
                if (_formKey.currentState.validate()) {
                  addProduct();
                  Navigator.pop(context);
                }
              },
              icon: Icon(Icons.done),
              label: Text('Kaydet'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/models/service.dart';

class UpdateService extends StatefulWidget {
  @override
  _UpdateCategoriestate createState() => _UpdateCategoriestate();
}

class _UpdateCategoriestate extends State<UpdateService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Güncelle'),
      ),
      body: UpdateBody(),
    );
  }
}

class UpdateBody extends StatefulWidget {
  _UpdateBodyState createState() => _UpdateBodyState();
}

class _UpdateBodyState extends State<UpdateBody> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference services =
      FirebaseFirestore.instance.collection('services');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  Service service;
  String _selectedItem;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    Future<void> updateService() {
      return services
          .doc(id)
          .update({
            'name': service.name,
            'description': service.description,
            'price': service.price,
            'category': service.category
          })
          .then((value) => print('Service Updated'))
          .catchError((error) => print("Failed to update service: $error"));
    }

    Function _validator = (value) {
      if (value == null || value.isEmpty) {
        return 'Bu alan boş bırakılamaz';
      }
      return null;
    };

    return FutureBuilder<DocumentSnapshot>(
      future: services.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          service = new Service.fromService(
            data['name'],
            data['description'],
            data['price'],
            data['category'],
          );
          _nameController.text = service.name;
          _descriptionController.text = service.description;
          _priceController.text = service.price;
          return Form(
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
                            items: snapshot.data.docs
                                .map((DocumentSnapshot document) {
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
                    service.name = _nameController.text;
                    service.description = _descriptionController.text;
                    service.price = _priceController.text;
                    service.category = categories.doc(_selectedItem);
                    if (_formKey.currentState.validate()) {
                      updateService();
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.done),
                  label: Text('Kaydet'),
                )
              ],
            ),
          );
        }
        return Text('loading');
      },
    );
  }
}

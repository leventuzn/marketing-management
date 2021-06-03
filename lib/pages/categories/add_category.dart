import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/models/Category.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');
    final Category category = new Category();

    Future<void> addCategory() {
      return categories
          .add({
            'firstname': category.name,
          })
          .then((value) => print('Category Added'))
          .catchError((error) => print("Failed to add user: $error"));
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
        title: Text('Kategori Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.category),
                hintText: 'Ad',
                labelText: 'Ad *',
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                category.name = value;
              },
              validator: _validator,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  addCategory();
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itms_flutter/models/category.dart';

class UpdateCategory extends StatefulWidget {
  @override
  _UpdateCategoriestate createState() => _UpdateCategoriestate();
}

class _UpdateCategoriestate extends State<UpdateCategory> {
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
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  Category category;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    Future<void> updateCategory() {
      return categories
          .doc(id)
          .update({
            'name': category.name,
            //'type': category.type,
          })
          .then((value) => print('Category Updated'))
          .catchError((error) => print("Failed to update category: $error"));
    }

    Function _validator = (value) {
      if (value == null || value.isEmpty) {
        return 'Bu alan boş bırakılamaz';
      }
      return null;
    };

    return FutureBuilder<DocumentSnapshot>(
      future: categories.doc(id).get(),
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
          category = new Category.fromCategory(
            data['name'],
            //data['type'],
          );
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: category.name,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.category),
                    hintText: 'Kategori adı',
                    labelText: 'Kategori adı *',
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    category.name = value;
                  },
                  validator: _validator,
                ),
                //DropdownButtonFormField(items: null, onChanged: null),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      updateCategory();
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itms_flutter/models/customer.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CollectionReference customers =
        FirebaseFirestore.instance.collection('customers');
    final Customer customer = new Customer();

    Future<void> addCustomer() {
      return customers
          .add({
            'firstname': customer.firstName,
            'lastname': customer.lastName,
            'phone': customer.phone,
            'email': customer.email,
            'address': customer.address,
            'identity': customer.identity,
          })
          .then((value) => print('Customer Added'))
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
        title: Text('Müşteri Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Ad',
                labelText: 'Ad *',
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                customer.firstName = value;
              },
              validator: _validator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Soyad',
                labelText: 'Soyad *',
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                customer.lastName = value;
              },
              validator: _validator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Telefon',
                labelText: 'Telefon *',
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                customer.phone = value;
              },
              validator: _validator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'E-posta',
                labelText: 'E-posta *',
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                customer.email = value;
              },
              validator: _validator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.home),
                hintText: 'Adres',
                labelText: 'Adres *',
              ),
              keyboardType: TextInputType.text,
              maxLength: 250,
              maxLines: 3,
              onChanged: (value) {
                customer.address = value;
              },
              validator: _validator,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.badge),
                hintText: 'TC Kimlik/Vergi No',
                labelText: 'TC Kimlik/Vergi No',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                customer.identity = value;
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  addCustomer();
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

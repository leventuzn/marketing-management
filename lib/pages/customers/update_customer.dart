import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:itms_flutter/models/customer.dart';

class UpdateCustomer extends StatefulWidget {
  @override
  _UpdateCustomerState createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
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
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  Customer customer;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    Future<void> updateCustomer() {
      return customers
          .doc(id)
          .update({
            'firstname': customer.firstName,
            'lastname': customer.lastName,
            'phone': customer.phone,
            'email': customer.email,
            'address': customer.address,
            'identity': customer.identity,
          })
          .then((value) => print('Customer Updated'))
          .catchError((error) => print("Failed to update customer: $error"));
    }

    Function _validator = (value) {
      if (value == null || value.isEmpty) {
        return 'Bu alan boş bırakılamaz';
      }
      return null;
    };

    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(id).get(),
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
          customer = new Customer.fromCustomer(
            data['firstname'],
            data['lastname'],
            data['phone'],
            data['email'],
            data['address'],
            data['identity'],
          );
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: customer.firstName,
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
                  initialValue: customer.lastName,
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
                  initialValue: customer.phone,
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
                  initialValue: customer.email,
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
                  initialValue: customer.address,
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
                  initialValue: customer.identity,
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
                      updateCustomer();
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

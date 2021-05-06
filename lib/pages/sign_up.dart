import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: FractionallySizedBox(
          widthFactor: .9,
          heightFactor: .6,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.alternate_email),
                  labelText: 'Email *',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password *',
                ),
                obscureText: true,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.check),
                  labelText: 'Confirm Password *',
                ),
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: .5,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        onPressed: null,
                        child: Text('Sign Up'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

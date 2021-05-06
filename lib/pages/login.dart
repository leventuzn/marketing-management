import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: .8,
          heightFactor: .5,
          child: Column(
            children: [
              //Email field
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.alternate_email),
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              //Password field
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              //Buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Forgot password
                  TextButton(
                    onPressed: null,
                    child: const Text('Forgot password?'),
                  ),
                  //Sign Up button
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                    child: const Text('Sign Up'),
                  ),
                  //Login button
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/home'),
                    child: const Text('Login'),
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

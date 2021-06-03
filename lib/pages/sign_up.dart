import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Kaydol'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/signup.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20),
        child: FractionallySizedBox(
          widthFactor: .8,
          heightFactor: .4,
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Email form field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.alternate_email),
                    hintText: 'E-postanızı girin',
                    labelText: 'E-posta *',
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                //Password form field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Şifrenizi girin',
                    labelText: 'Şifre *',
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: .5,
                        //Sign up button
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              userCredential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text('Kaydol'),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserCredential userCredential;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String admin = "admin@admin.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Kullanıcı Girişi'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: .8,
          heightFactor: .4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.9),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Email field
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.alternate_email),
                    labelText: 'E-posta',
                  ),
                  controller: _emailController,
                ),
                SizedBox(
                  height: 5,
                ),
                //Password field
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.lock),
                    labelText: 'Şifre',
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                //Buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Sign Up button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/sign_up'),
                        child: const Text('Kaydol'),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                    //Login button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                            Navigator.pushNamed(context, '/home');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        },
                        child: const Text('Giriş'),
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

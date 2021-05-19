import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
                  obscureText: true,
                ),
                //Buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Forgot password
                    TextButton(
                      onPressed: null,
                      child: const Text(
                        'Şifremi unuttum',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    //Sign Up button
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                      child: const Text('Kaydol'),
                    ),
                    //Login button
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/home'),
                      child: const Text('Giriş'),
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

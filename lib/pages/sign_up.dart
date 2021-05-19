import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
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
          widthFactor: .9,
          heightFactor: .5,
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
                ),
                //Password form field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'Şifrenizi girin',
                    labelText: 'Şifre *',
                  ),
                  obscureText: true,
                ),
                //Confirm password form field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.check),
                    hintText: 'Şifrenizi tekrar girin',
                    labelText: 'Şifre (Tekrar) *',
                  ),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FractionallySizedBox(
                        widthFactor: .5,
                        //Sign up button
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          onPressed: () {},
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

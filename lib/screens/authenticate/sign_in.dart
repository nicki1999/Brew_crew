import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
  final Function toggleView;
  SignIn({required this.toggleView});
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  String email = "";
  String password = "";
  String error = "";
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.brown[400],
              title: Text(
                'Sign in to Brew Crew',
                textDirection: TextDirection.ltr,
              ),
              actions: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.brown[400],
                    ),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration,
                      validator: (value) =>
                          value!.isNotEmpty ? null : 'Please enter an email',
                      onChanged: (value) => setState(() {
                        email = value;
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (value) => value!.length < 6
                          ? 'Please enter a password at least 6 chars long'
                          : null,
                      onChanged: (value) => setState(() {
                        password = value;
                      }),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (result == null) {
                            setState(() {
                              error = 'Something went wrong!';
                              _loading = false;
                            });
                          }
                        }
                        print(email);
                        print(password);
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 17),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pink[400])),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.brown[100],
          );
  }
}

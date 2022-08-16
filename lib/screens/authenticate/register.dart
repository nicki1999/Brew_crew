import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String error = '';
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.brown[400],
              title: Text(
                'Sign up to Brew Crew',
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
                  label: Text('Sign in'),
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
                      validator: (value) => value!.isNotEmpty
                          // && value.contains('@')
                          ? null
                          : 'Email is not valid',
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
                      validator: (value) =>
                          value!.isNotEmpty && value.length >= 6
                              ? null
                              : 'Enter a password at least 6 chars long',
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
                              await _auth.registerWithEmailAndPassword(
                                  email: email, password: password);
                          if (result == null) {
                            setState(() {
                              error = 'Please supply a valid email';
                              _loading = false;
                            });
                          }
                          print(email);
                          print(password);
                        }
                      },
                      child: Text(
                        'Sign up',
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

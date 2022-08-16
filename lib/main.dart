import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('initializing app failed');
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<ModeledUser?>.value(
            initialData: null,
            value: AuthService().user,
            child: MaterialApp(
              home: Wrapper(),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        else {
          return Loading();
        }
      },
    );
  }
}

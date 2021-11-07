import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tcstore/models/local_user.dart';
import 'package:tcstore/screens/add_item.dart';
import 'package:tcstore/screens/authenticate/register.dart';
import 'package:tcstore/screens/authenticate/sign_in.dart';
import 'package:tcstore/screens/setting.dart';
import 'package:tcstore/services/authentication.dart';
import 'package:tcstore/wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Text('Something went wrong'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const Home();
        }
        return const MaterialApp(home: Scaffold(body: Text('Loading')));
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<LocalUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: 'Georgia',
          // textTheme: const TextTheme(
          //   headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal),
          //   bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          // ),
        ),
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        routes: {
          SignIn.routeName: (context) => const SignIn(),
          Register.routeName: (context) => const Register(),
          Setting.routeName: (context) => Setting(),
          AddItem.routeName: (context) => const AddItem(),
        },
      ),
    );
  }
}

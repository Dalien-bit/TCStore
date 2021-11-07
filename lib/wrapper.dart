import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcstore/models/local_user.dart';
import 'package:tcstore/screens/authenticate/register.dart';
import 'package:tcstore/screens/authenticate/sign_in.dart';
import 'package:tcstore/screens/home_page.dart';
import 'package:tcstore/services/authentication.dart';

// class Wrapper extends StatefulWidget {
//   const Wrapper({Key? key}) : super(key: key);
//   @override
//   State<Wrapper> createState() => _WrapperState();
// }
// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<LocalUser?>(context);
//     if (user == null) {
//       return const SignIn();
//     } else {
//       return HomePage();
//     }
//   }
//}

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LocalUser?>(context);
    if (user == null) {
      return const SignIn();
    } else {
      return Home();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:tcstore/services/authentication.dart';

class Setting extends StatelessWidget {
  Setting({Key? key}) : super(key: key);
  static const routeName = '/setting';
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            const ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: Text('Profile'),
            ),
            const Divider(
              height: 10,
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(
                Icons.format_list_bulleted,
                color: Colors.black,
              ),
              onTap: () {},
              title: const Text("Options"),
              //tileColor: Colors.grey,
            ),
            const Divider(
              height: 10,
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text('Log Out'),
              onTap: () {
                _auth.signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

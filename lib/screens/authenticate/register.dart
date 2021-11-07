import 'package:flutter/material.dart';
import 'package:tcstore/services/authentication.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String message = '';
  String name = '';
  String shopName = '';
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Sign In',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.length < 6 ? 'Enter a bigger password' : null,
                        obscureText: !_showPassword,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Text('Show Password'),
                          Checkbox(
                              value: _showPassword,
                              onChanged: (bool? val) {
                                setState(() {
                                  _showPassword = val!;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an name' : null,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Name',
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an Organisation Name' : null,
                        onChanged: (val) {
                          setState(() {
                            shopName = val;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Organisation name',
                        ),
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20.0),
                      TextButton(
                        onPressed: () async {
                          setState(() {
                            message = 'Please wait loading';
                          });
                          if (_formKey.currentState!.validate()) {
                            dynamic result =
                                await _auth.registerWithEmailPassword(
                                    email, password, name, shopName);
                            if (result == null) {
                              setState(() {
                                message =
                                    'Please enter valid email id and password';
                              });
                            } else {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

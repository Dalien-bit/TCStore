import 'package:flutter/material.dart';
import 'package:tcstore/models/local_user.dart';
import 'package:tcstore/screens/authenticate/register.dart';
import 'package:tcstore/services/authentication.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/sign-in';
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String message = '';

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
              ),
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width * 2 / 3,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                          obscureText: !showPassword,
                          validator: (val) => val!.length < 6
                              ? 'Enter a bigger password'
                              : null,
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
                                value: showPassword,
                                onChanged: (bool? val) {
                                  setState(() {
                                    showPassword = val!;
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () async {
                                setState(() {
                                  message = 'Please wait loading';
                                });
                                if (_formKey.currentState!.validate()) {
                                  dynamic result = await _auth
                                      .signInWithEmailPassword(email, password);
                                  if (result == null) {
                                    setState(
                                      () {
                                        message =
                                            'Cannot sign in with those credentials';
                                      },
                                    );
                                  }
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Register.routeName);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

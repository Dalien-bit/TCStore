import 'package:flutter/material.dart';
import 'package:tcstore/services/authentication.dart';
import 'package:tcstore/services/database.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);
  static const routeName = '/add-item';

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String nameOfItem = '';
  final String _authUid = AuthService().uid!;

  //String photo = 'photo';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Item',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter a item name' : null,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Item Name',
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 32.0),
                          borderRadius: BorderRadius.circular(5.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(5.0))),
                  onChanged: (value) {
                    nameOfItem = value;
                  },
                ),
              ),
              SizedBox(
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: _authUid).addItem(nameOfItem);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Create New Item',
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

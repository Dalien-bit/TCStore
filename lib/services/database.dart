import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/data/user_data.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name, String shopName) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'shop name': shopName,
    });
  }

  //add an item
  Future addItem(String name) async {
    await userCollection.doc(uid).collection('items').doc().set({
      'item name': name,
    });
  }

  // Get user streams
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}

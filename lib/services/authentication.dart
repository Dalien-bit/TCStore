import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcstore/models/local_user.dart';
import 'package:tcstore/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create a user obj based on FirebaseUser
  LocalUser? _userFromFirebaseUser(
    User? user,
  ) {
    if (user == null) {
      return null;
    }
    return LocalUser(
      uid: user.uid,
    );
  }

  // get the uid
  String? get uid {
    return _auth.currentUser.uid;
  }

  //auth change user stream
  Stream<LocalUser?> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // register in with email and password
  Future registerWithEmailPassword(
      String email, String password, String name, String shopName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(name, shopName);
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}

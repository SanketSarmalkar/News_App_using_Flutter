

import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/models/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj on firebaseuser
  UserUid? _userFromFirebaseUser(User? user){
      return (user!=null)? UserUid(uid: user.uid):null;
  }

  Stream<UserUid?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //signIn with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // register with email & pass
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // signout
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
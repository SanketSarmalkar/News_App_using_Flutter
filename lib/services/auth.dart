import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/controller/email_info_controller.dart';
import 'package:news_app/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  EmailInfoController emailInfoController = Get.put(EmailInfoController());

  // create user obj on firebaseuser
  UserUid? _userFromFirebaseUser(User? user) {
    return (user != null) ? UserUid(uid: user.uid) : null;
  }

  Stream<UserUid?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //check for verified email
  bool emailVerified() {
    var user = _auth.currentUser;
    if (user!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  //signIn with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (_auth.currentUser!.emailVerified) {
        emailInfoController.verificationMode(true);
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // register with email & pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // final actionCodeSettings = ActionCodeSettings(
      //   url: "http://www.example.com/verify?email=${user?.email}",
      //   iOSBundleId: "com.example.ios",
      //   androidPackageName: "com.example.android",
      // );
      await user!.sendEmailVerification();
      // //return _userFromFirebaseUser(user);
      // Get.snackbar(
      //   "Success",
      //   "Successfully registered..",
      //   icon: const Icon(Icons.check_circle, color: Colors.green),
      //   backgroundColor: Colors.black12,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      await _auth.signOut();
      return 1;
    } catch (e) {
      //print(e.toString()+"&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
      return null;
    }
  }

  // signout
  Future signOut() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await _auth.signOut();
      emailInfoController.verificationMode(false);
      return _userFromFirebaseUser(null);
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // signInwithGoogle
  Future signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      //Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // once signed in, return the UserCredential
      UserCredential result = await _auth.signInWithCredential(credential);

      User? user = result.user;
      emailInfoController.verificationMode(true);
      return _userFromFirebaseUser(user);
    } catch (e) {
      //print(e);
      return null;
    }
  }
}

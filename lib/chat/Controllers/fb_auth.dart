import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../g.dart' as g;


class FBAuth{
  static FBAuth get instanace => FBAuth();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> addUserUsingEmail(BuildContext context, String emailAddress) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: g.cstr(g.cmdval("u_password"),"88888888")
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      //showAlertDialog(context,e.code);
    } catch (e) {
      print(e);
    }
  }
  Future<String> addUser(BuildContext context, String emailAddress,String password) async{
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      //showAlertDialog(context,e.code);
    } catch (e) {
      print(e);
    }
  }
}
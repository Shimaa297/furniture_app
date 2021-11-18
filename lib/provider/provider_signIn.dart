import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/auth/data/repository_data.dart';
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/database/database_method.dart';

class ProviderSignIn extends ChangeNotifier{

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount _user;
  GoogleSignInAccount get user=> _user;



  Future googleLogin() async{
   try {
     final googleUser = await googleSignIn.signIn();
     if (googleUser == null) return;
     //add data to _user
     _user = googleUser;

     final googleAuth = await googleUser.authentication;

     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken,
     );

     await FirebaseAuth.instance.signInWithCredential(credential);
   } catch (e){
     print(e.toString());
   }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  UserModel myUser;

  definerUser(String uid) async
  {
    CollectionReference refUsers = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot doc = await refUsers.doc(uid).get();
    UserModel thisUser = UserModel.fromJson(doc.data());
    myUser = thisUser;
    notifyListeners();
    return thisUser;
  }

  updateUserInfo(UserModel userModel, String currentUserId) async
  {
    myUser.username = userModel.username;
    myUser.email = userModel.email;
    myUser.photo = userModel.photo;

    notifyListeners();
    await DatabaseMethod().updateUserInfo(userModel, currentUserId);
  }
}
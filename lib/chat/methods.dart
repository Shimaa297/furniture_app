import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Auth{

  Future<User> createAccount(String name, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    try{
      User user = (await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password)).user;

      if(user != null)
      {
        print('Account created Success');

        user.updateProfile(displayName: name);

        await _fireStore.collection('users').doc(_auth.currentUser.uid).set({
          'name' : name,
          'email' : email,
          'status' : 'Unavalible',
        });
        return user;
      } else{
        print('Account creation failed');
        return user;
      }
    } catch (e)
    {
      print(e);
      return null;
    }
  }

  Future<User> SignIn(String email, String password) async{

    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try{
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password))
          .user;

      if(user != null)
      {
        print('Login Sucessfull');

        _firestore.collection('users').doc(_auth.currentUser.uid).get()
            .then((value) {
             // user.updateProfile(displayName: value['name']);
            user.updateEmail(email);
        });
       // user.updateProfile(displayName: email);
        return user;
      } else{
        print('Login Faild');
        return user;
      }
    } catch(e){}
  }

  Future logOut() async
  {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      await _auth.signOut();
    } catch (e){
      print('error');
    }
  }
}

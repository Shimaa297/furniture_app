import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';


class Auth{
   UserModel userModel;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

   Future<void> userLogin(String email, String password) async
  {
   await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
   ).then((value){
          print(email);
          print(password);
          print("user Login");
    }).catchError(
            (e){
              print(e.toString());
               }
            );
  }

   Future<void> userRegister(String name, phone, email, password, File image) async
   {
      UserModel userModel = UserModel(
       name: name,
       email: email,
       password: password,
       phone: phone,
       avatar: image.path,
     );

    await _auth.createUserWithEmailAndPassword(
         email: email,
         password: password,
     ).then((value) async{
      User user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid' : user.uid,
        'email' : email,
        'password' : password,
        'name' : name,
        'phone' : phone,
      });
       print(userModel.email);
       print(userModel.password);
       print("User Register");
     }).catchError(
             (e){
           print(e.toString());
         }
     );
   }


   showError(String errorMessage, context)
   {
     showDialog(
         context: context,
         builder: (BuildContext context)
         {
           return AlertDialog(
             title: Text('ERROR !!', style: SubtitleTextStyle,),
             content: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Container(
                   height: 100,
                   width: 100,
                   child: helpImage('https://www.seekpng.com/png/detail/11-110262_sad-emoji-png-clipart-sad-emoji.png', 0.0),
                 ),
                 SizedBox(height: 5,),
                 Text(
                     errorMessage,
                   overflow: TextOverflow.visible,
                   style: BodyTextStyle,
                 ),
               ],
             ),
             actions: [
               helpIconButton(
                   ColorsApp.primaryColor,
                   BoxShape.circle,
                   ()
                   {
                     Navigator.pop(context);
                   },
                   Icons.arrow_forward_ios,
                   Colors.black)
             ],
           );
         }
     );
   }

}
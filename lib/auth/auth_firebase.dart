import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';


class Auth{
   UserModel userModel;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

    userLogin({
   @required String email, @required String password}) async
  {
    _auth.signInWithEmailAndPassword(
        email: userModel.email, 
        password: userModel.password).then((value){
          print(userModel.email);
          print(userModel.password);
    }).catchError(
            (errorMessage, context){
              showError(errorMessage, context);
               }
            );
  }

   userRegister(
   {
     String name, phone, email, password
   }) async
   {
     UserModel userModel = UserModel(
       name: name,
       email: email,
       password: password,
       phone: phone,
     );

     _auth.createUserWithEmailAndPassword(
         email: email,
         password: password,
     ).then((value){
       print(userModel.email);
       print(userModel.password);
     }).catchError(
             (errorMessage, context){
           showError(errorMessage, context);
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
             content: Text(
                 errorMessage,
               overflow: TextOverflow.visible,
               style: BodyTextStyle,
             ),
             actions: [
               helpIconButton(
                   ColorsApp.primaryColor,
                   BoxShape.circle,
                   ()
                   {
                     Navigator.pop(context);
                   },
                   Icons.arrow_back_ios,
                   Colors.black)
             ],
           );
         }
     );
   }
}
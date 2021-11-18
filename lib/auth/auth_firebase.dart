
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/screens/home_page.dart';


class Auth{

  static final FirebaseAuth _auth = FirebaseAuth.instance;

   Future userLogin(String email, String password) async
  {
    try{
      var result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User firebaseUser = result.user;
      //await refUsers.doc(firebaseUser.uid);
      return firebaseUser.uid;
    }catch(e)
    {
      helpShowToast(e.toString());
      print('ERROR IS : $e');
    }
  }

   Future userRegister(String email, password) async
   {
     try{
       var result = await _auth.createUserWithEmailAndPassword(
         email: email,
         password: password,
       );
       User firebaseUser = result.user;
       return firebaseUser.uid;
     } catch(e)
     {
       helpShowToast(e.toString());
       print('ERROR IS : $e');
     }
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
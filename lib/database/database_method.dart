
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/auth/model/user_model.dart' as userModel;
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/help/constants/help.dart';

class DatabaseMethod {

   final CollectionReference refUsers = FirebaseFirestore.instance.collection('users');
  // collection User
   setUserInfo(var uid , userMap)
   {
     var firebase = FirebaseFirestore.instance;
     return firebase.collection('users').doc(uid).set(userMap);

   }
   getUserInfo(String uid) async
   {
     DocumentSnapshot doc = await refUsers.doc(uid).get();
     return userModel.UserModel.fromJson(doc.data());
   }

   Future<String> uploadImageToStorage(File imageFile, String imageId ) async
   {
     FirebaseStorage storage = FirebaseStorage.instance;
     Reference ref = storage.ref().child('image_ $imageId');
     TaskSnapshot taskSnapshot = await ref.putFile(imageFile);
     return await taskSnapshot.ref.getDownloadURL();
   }

   updateUserInfo(userModel.UserModel updateUser, String currentUserId)
   {
     try{
       refUsers.doc(currentUserId).update({
         'photo' : updateUser.photo,
         'name' : updateUser.username,
         'email' : updateUser.email
        }
       );
     }catch(e)
     {
       helpShowToast('$e');
       print(e);
     }
   }

   getPhotoFromFirebase(String uid) async
   {
     DocumentSnapshot doc = await refUsers.doc(uid).get();
     return doc['photo'];
   }

   getNameFromFirebase(String uid) async
   {
     DocumentSnapshot doc = await refUsers.doc(uid).get();
     return doc['username'];
   }

   getEmailFromFirebase(String uid) async
   {
     DocumentSnapshot doc = await refUsers.doc(uid).get();
     return doc['email'];
   }
}
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:learn_app/custom_widget/constant_button.dart';
// import 'package:learn_app/custom_widget/textForm.dart';
// import 'package:learn_app/screens/profile/chatRoom.dart';
// import 'package:learn_app/screens/profile/methods.dart';
//
// class Profile extends StatefulWidget {
//
//   @override
//   _ProfileState createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   Map< String, dynamic> userMap;
//
//
//   // File _image;
//   // Future uploadFile()async
//   // {
//   //   final ImagePicker _picker = ImagePicker();
//   //     await _picker.pickImage(source: ImageSource.gallery).then((value) => (image){
//   //       setState(() {
//   //         _image = image;
//   //       });
//   //     });
//   //     // StorageReference storageReference = FirebaseStorage.instance.ref().child(
//   //     //   '${lo}'
//   //     // );
//   // }
//
//   final TextEditingController  _search = TextEditingController();
//   bool isLoading = false;
//   void onSearch() async {
//
//     FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//     setState(() {
//       isLoading = true;
//     });
//     await _firestore
//         .collection('users')
//         .where('email', isEqualTo: _search.text)
//         .get()
//         .then((value)
//     {
//       setState(() {
//         userMap = value.docs[0].data();
//         isLoading = false;
//       });
//       print(userMap);
//     });
//   }
//   String chatRoomId(String user1, String user2)
//   {
//     if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0])
//     {
//       return '$user1$user2';
//     }else{
//       return '$user2$user1';
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//
//               defaultTextForm(
//                 label: 'Search',
//                 controller: _search,
//                 // validate: (){},
//               ),
//               TextButton(
//                   onPressed: onSearch,
//                   child: Text('Search')
//               ),
//               userMap != null ? ListTile(
//                 onTap: ()
//                 {
//                   String roomId = chatRoomId(
//                       _auth.currentUser.displayName,
//                       userMap['name']);
//                   navigateTo(context, ChatRoom(
//                     chatRoomId: roomId,
//                     userMap: userMap,
//                   )
//                   );
//                 },
//                 title: Text(userMap['name']),
//                 subtitle: Text(userMap['email']),
//                 trailing: Icon(Icons.chat),
//               ) : Container(),
//               // Container(
//               //   child: TextButton(
//               //     onPressed: ()
//               //     {
//               //       String roomId = chatRoomId(
//               //            _auth.currentUser.displayName,
//               //             userMap['name']
//               //       );
//               //       navigateTo(context, ChatRoom(
//               //         chatRoomId: roomId,
//               //         userMap: userMap,
//               //       )
//               //       );
//               //     },
//               //     child: Text('Click On'),
//               //   ),
//               // ),
//             ],
//           )
//       ),
//     );
//   }
// }
//
//
//
//

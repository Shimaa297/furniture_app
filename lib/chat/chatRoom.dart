import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/src/intl/date_format.dart';


class ChatRoom extends StatelessWidget {

  final Map< String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({this.userMap , this.chatRoomId});

  final TextEditingController _massage =TextEditingController();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
 // final _auth = Auth();

  void onSendMessage()async
  {
   if(_massage.text.isNotEmpty)
   {
     final f = new DateFormat('yyyy-MM-dd hh:mm a');
     var annual = DateTime.parse('2021-01-01');

     Map<String, dynamic> messages = {
       'sendBy' :  _auth.currentUser.displayName,
       'message' : _massage.text,
       //'time' : FieldValue.serverTimestamp(),
       'time' : f,

     };
     _massage.clear();

     await _fireStore.collection('chatroom')
         .doc(chatRoomId)
         .collection('chats')
         .add(messages);

   } else{
     print('Enter Some Text');
   }
  }

  imageFromGallery(context) async
  {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 85);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(userMap['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _fireStore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy('time', descending: false)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                {
                  if(snapshot.data != null)
                  {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index)
                        {
                          Map<String, dynamic> map =
                          snapshot.data.docs[index].data();
                          return messages(size, map);
                        }
                    );
                  } else{
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 11,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    Container(
                      height: size.height / 12,
                      width: size.width / 1.35,
                      child: TextField(
                        controller: _massage,
                        decoration: InputDecoration(
                            labelText: 'Send Massage',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: onSendMessage,
                    ),
                     GestureDetector(
                       onTap: (){},
                         child: Icon(Icons.add_a_photo)
                     ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map,)
  {
    final f = new DateFormat('yyyy-MM-dd hh:mm a');
    var annual = DateTime.parse('2021-01-01');
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[100],
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Text(
            // f.format(DateTime.parse(map['time'].toString()),
            // '${ f.format(DateTime.parse(map['time']))}'
            '${DateFormat('yyy-MM-dd').format(DateTime.now())}',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        SizedBox(height: 15,),
        Container(
          width: size.width,
          alignment: map['sendBy'] == _auth.currentUser.displayName
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color:  map['sendBy'] == _auth.currentUser.displayName
                  ? Colors.black
                  : Colors.grey[300],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  map['message'],
                style: TextStyle(
                  color:  map['sendBy'] == _auth.currentUser.displayName
                      ? Colors.white
                      : Colors.black45,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),
                SizedBox(height: 5,),
                Text(
                   // f.format(DateTime.parse(map['time'].toString()),
                 // '${ f.format(DateTime.parse(map['time']))}'
                  '${DateFormat('MM-dd hh:mm').format(DateTime.now())}',
                  style: TextStyle(color: Colors.blueGrey),
                    ),
                // Text(
                // '',
                //   style: TextStyle(
                //     color:  map['time'] == _auth.currentUser.displayName
                //         ? Colors.white
                //         : Colors.black45,
                //     fontSize: 16,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
            ],
            ),
          ),
        ),
      ],
    );
  }
}


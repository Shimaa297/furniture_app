import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/help/image_picker_widget.dart';
import 'package:path/path.dart';
import 'package:untitled/provider/provider_signIn.dart';
import 'package:untitled/sharedPrefernce/cache_helper.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File image;
  String photoProfile;
  bool isLoading = false;
  Future pickImage(ImageSource source) async {
    try {
      // final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imageTemporary = File(image.path);
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image : $e');
    }
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }
  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }
  bool val = false;
  bool status = false;
  bool closeApp = false;
  void onSwitch(bool value) {
    setState(() {
      val = value;
    });
  }
  UserModel userModel;
  String uid;
  @override
  Widget build(BuildContext context) {
    userModel = Provider.of<ProviderSignIn>(context, listen: false).myUser;
    retrieveData() async {
      final userAlreadyLoggedInId = await CacheHelper.checkIfLoggedIn();
      if (userAlreadyLoggedInId != true) {
        await Provider.of<ProviderSignIn>(context, listen: false)
            .definerUser(userAlreadyLoggedInId);
        print('Ok');
      }
    }

    @override
    void didChangeDependencies() async {
      await retrieveData();
      var userProvider = Provider.of<ProviderSignIn>(context, listen: false);
      uid = userProvider.myUser?.uid;
      photoProfile = userProvider.myUser?.photo;
      // await userProvider.getLastMessages(userProvider.myUser!);
      setState(() {
        isLoading = false;
      });

      super.didChangeDependencies();
    }

    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return helpLoading();
            else if (snapshot.hasData) {
              return Column(
                children: [
                  headerContent(context, 'Profile'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            photoProfile == null
                                ? CircleAvatar(
                                      radius: 50,
                                      backgroundColor: ColorsApp.col,
                                      child: Icon(Icons.person)
                                )
                            :
                            ClipOval(
                              child: Container(
                               height: 120,
                               width: 120,
                               child: helpImage( Provider.of<ProviderSignIn>(context).myUser?.photo, 200),
                      ),
                              ),
                            // ClipOval(
                            //   child: image != null
                            //       ? Container(
                            //     height: 120,
                            //     width: 120,
                            //     child: helpImage('${user.photoURL}', 200),
                            //   )
                            //   // Image.file(image, fit: BoxFit.contain, height: 150, width: 150,) :
                            //       : CircleAvatar(
                            //     radius: 50,
                            //       backgroundColor: ColorsApp.col,
                            //       child: Icon(Icons.person)
                            //   ),
                            // ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                user != null ?
                                Text(
                                  '${user.displayName}',
                                  style: TitleTextStyle,
                                )
                                :  Text(
                                  '${userModel.username}',
                                  style: TitleTextStyle,
                                )
                                ,
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  '${user.email}',
                                  style: BodyTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Setting', style: SubtitleTextStyle,),
                        SizedBox(
                          height: 10,
                        ),
                        helpSetting(
                          iconColor: ColorsApp.defTextColor,
                          icon: Icons.language,
                          text: 'Change Language',
                          textColor: ColorsApp.defTextColor,
                          function: () {},
                        ),
                        helpSetting(
                          iconColor: ColorsApp.defTextColor,
                          icon: Icons.brightness_4_outlined,
                          text: 'Dark Mode',
                          textColor: ColorsApp.defTextColor,
                          function: () {},
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text('Notification', style: SubtitleTextStyle,),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Notifications',
                              style: BodyTextStyle
                            ),
                            FlutterSwitch(
                              padding: 4.0,
                              toggleSize: 30.0,
                              width: 60.0,
                              inactiveColor: ColorsApp.grayColor,
                              value: val,
                              onToggle: onSwitch,
                              activeColor: ColorsApp.primaryColor,
                            ),
                            // Switch(
                            //   value: val,
                            //   onChanged: onSwitch,
                            //   activeColor: ColorsApp.primaryColor,
                            //   activeTrackColor: ColorsApp.col,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something Went Wrong !'),
              );
            } else {
              return Stack(
                children: [
                  Positioned(
                    top: -100,
                    left: -100,
                    right: -100,
                    child: ClipOval(
                      child: Container(
                          color: ColorsApp.col,
                          height: 250.0,
                          width: double.infinity),
                    ),
                  ),
                  headerContent(context, 'Profile'),
                  Positioned(
                    top: helpHeight(context) - 610,
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        Stack(alignment: Alignment.bottomRight, children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[50],
                            radius: 80,
                            child: helpImage(user.photoURL, 200),
                          ),
                          helpIconButton(
                            ColorsApp.primaryColor,
                            BoxShape.circle,
                            () {},
                            Icons.edit,
                            ColorsApp.defTextColor,
                          )
                        ]),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          user.displayName,
                          style: TitleTextStyle,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        helpSetting(
                          iconColor: ColorsApp.defTextColor,
                          icon: Icons.language,
                          text: 'Change Language',
                          textColor: ColorsApp.defTextColor,
                          function: () {},
                        ),
                        helpSetting(
                          iconColor: ColorsApp.defTextColor,
                          icon: Icons.brightness_4_outlined,
                          text: 'Dark Mode',
                          textColor: ColorsApp.defTextColor,
                          function: () {},
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

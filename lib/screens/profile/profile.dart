import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    Map< String, dynamic> userMap;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting)
              return helpLoading();
            else if (snapshot.hasData) {
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
                            child: helpImage(
                                '${user.photoURL}',
                                200),
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
                          '${user.displayName}',
                          style: TitleTextStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${user.email}',
                          style: SubtitleTextStyle,
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
                            child: helpImage(
                              user.photoURL,
                                200),
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

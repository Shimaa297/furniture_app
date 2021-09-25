import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/screens/category/category_screen.dart';
import 'package:untitled/screens/profile/profile.dart';


Widget headerContent(
    context,
    String title,
    )
{
  final user = FirebaseAuth.instance.currentUser;

  return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: ()
            {
              helpNavigateTo(context, ProfileScreen());
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorsApp.defTextColor),
                    borderRadius: BorderRadius.circular(10.0)),
                height: 50,
                width: 50,
                child: helpImage(
                    '${user.photoURL}',
                    10.0)),
          ),
        ),
      ],
      title: Text(
        title,
        style: SubtitleTextStyle,
      ),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: helpIconButton(
          Colors.white,
          BoxShape.rectangle,
              () {
            helpNavigateTo(context, CategoryScreen());
          },
          Icons.sort,
          Colors.black,
        ),
      )
  );
}


Widget footerContent(context)
{
  return Container(
    height: helpHeight(context) * .3,
    width: double.infinity,
    color: ColorsApp.defTextColor,
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    3,
                        (index) => Row(
                  children: [
                    helpIconButton(
                      Colors.transparent,
                      BoxShape.circle,
                          (){},
                      Icons.account_balance_outlined,
                      Colors.white,
                    ),
                    SizedBox(width: 50,),
                    Text(
                      'facebook/shimaa.com',
                      style: BodyTextStyle.copyWith(color: Colors.white),
                    ),
                  ],
                )
                ),
              ),
            ],
          ),
          SizedBox(width: 200,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: List.generate(
                    3,
                        (index) => Row(
                      children: [
                        helpIconButton(
                          Colors.transparent,
                          BoxShape.circle,
                              (){},
                          Icons.location_on,
                          Colors.white,
                        ),
                        SizedBox(width: 50,),
                        Text(
                          '15 Alamal street-Alexandria-Egypt',
                          style: BodyTextStyle.copyWith(color: Colors.white),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
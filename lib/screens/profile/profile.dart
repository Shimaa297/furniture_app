import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
            headerContent( context,'Profile'),

            Positioned(
              top: helpHeight(context) - 610,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children : [
                      CircleAvatar(
                        backgroundColor: Colors.grey[50],
                        radius: 80,
                        child: helpImage('https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png', 200),
                      ),
                      helpIconButton(
                          ColorsApp.primaryColor,
                          BoxShape.circle,
                          (){},
                          Icons.edit,
                          ColorsApp.defTextColor,
                      )
              ]
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Shimaa Ragab',
                    style: TitleTextStyle,
                  ),
                  SizedBox(height: 50,),
                  helpSetting(
                    iconColor: ColorsApp.defTextColor,
                    icon: Icons.language,
                    text: 'Change Language',
                    textColor: ColorsApp.defTextColor,
                    function: (){},
                  ),
                  helpSetting(
                    iconColor: ColorsApp.defTextColor,
                    icon: Icons.brightness_4_outlined,
                    text: 'Dark Mode',
                    textColor: ColorsApp.defTextColor,
                    function: (){},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

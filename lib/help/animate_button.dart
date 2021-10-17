
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:untitled/chat/chatRoom.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants/help.dart';
import 'dart:io';


String _whatsapp = '+201284183181';
final phoneNumber = '+201284183181';
String facebookUrl = 'https://www.facebook.com/profile.php?id=100007864757487';
Widget floatingAnimate(context) {
  return SpeedDial(
    backgroundColor: ColorsApp.secColor,
    animatedIcon: AnimatedIcons.menu_close,
    //icon: FontAwesome.comment,
    overlayOpacity: 0.4,
    spacing: 12,
    spaceBetweenChildren: 12,
    children: [
      SpeedDialChild(
        child: Icon(Icons.chat),
        backgroundColor: ColorsApp.primaryColor,
        onTap: () => helpShowToast('Chat...'),
        labelWidget: labelContent(context),
      ),
      SpeedDialChild(
          child: Icon(FontAwesome.whatsapp),
          backgroundColor: ColorsApp.primaryColor,
         // label: 'Whatsapp',
          onTap: (){
            launchWhatsapp(number: _whatsapp , message: "hello can I ask");
          }
      ),
      SpeedDialChild(
          child: Icon(FontAwesome.facebook_f),
          backgroundColor: ColorsApp.primaryColor,
          onTap: (){
            launch(facebookUrl);
          }
      ),
      SpeedDialChild(
          child: Icon(
            Icons.phone,
            color: ColorsApp.defTextColor,
          ),
          onTap: () async{
            // direct phone call
          //  await FlutterPhoneDirectCaller.callNumber(phoneNumber);
            // indirect phone call
            launch('tel://$phoneNumber');
          },
          backgroundColor: ColorsApp.primaryColor,
      ),
    ],
  );
}

 launchWhatsapp({@required number, @required message}) async {

  String url()
  {
    if(Platform.isIOS)
    {
      return 'whatsapp://wa.me/$number/?text=${Uri.parse(message)}';
    } else{
      return 'whatsapp://send?phone=$number&text=$message';
    }
  }
  await canLaunch(url()) ? launch(url()) : helpShowToast("There is no WhatsApp on your Device!");
}


Widget labelContent(context) {
  return Column(
    children: [
      Row(
        children: [
          helpContainerShadow(
              Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: helpImage(
                    'https://i.pinimg.com/550x/4d/72/97/4d7297dad94265c0acbc3b677d418935.jpg',
                    5.0),
              )),
          Container(
            width: 250,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: helpContainerShadow(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome to our site, if you need help simply ready to this message, we are online and ready to help.',
                  style: BodyTextStyle.copyWith(height: 1.6),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ],
      ),
      GestureDetector(
        onTap: ()=> helpNavigateTo(context, ChatRoom()),
        child: Container(
          width: 250,
          height: 50,
          child: helpTextField(
            fillColor: ColorsApp.col,
            radius: 50.0,
            labelText: 'Write a reply',
          ),
        ),
      )
    ],
  );
}

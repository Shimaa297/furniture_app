import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: FlutterLogo(size: 100,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ELAN',style: SubtitleTextStyle.copyWith(fontSize: 25),),
                Text(
                  'DALOS',
                  style: TextStyle(
                      color: ColorsApp.secColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(
              'lkbk ewuibwfmr ogn[oklc,xp omewie,.a2ithri ugfmjkdbfue wfhe jfqekbrugrjed njkaugf89e8 jmqklnduge9f 8g3bbof ug9e',
              style: BodyTextStyle.copyWith(color: ColorsApp.grayColor, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 30,
                child: Divider(color: ColorsApp.grayColor, thickness: 3,)),
            Text('Contact us', style: TitleTextStyle,),
            SizedBox(height: 10,),
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
                            ColorsApp.primaryColor,
                            BoxShape.circle,
                                (){},
                            Icons.account_balance_outlined,
                            Colors.black38,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            'facebook/shimaa.com',
                            style: BodyTextStyle.copyWith(color: ColorsApp.defTextColor),
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
}

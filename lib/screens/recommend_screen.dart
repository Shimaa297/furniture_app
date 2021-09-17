import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';

class MobileRecommendedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerContent(context, 'Recommended'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                List.generate(8, (index) => buildListProduct(context)),
              ),
            ),
          ),
          ListView.separated(
              itemBuilder:  (context,index)=> buildListRecommended(),
              separatorBuilder: (context,index)=> Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Divider(color: ColorsApp.grayColor,),
              ),
              itemCount: 10
          )
        ],
      ),
    );
  }

  buildListRecommended()=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      children: [
        Container(
          height: 150,
          width: 150,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              helpImage(
                  'https://media-cdn.tripadvisor.com/media/photo-s/1d/91/47/a6/our-double-deluxe-rooms.jpg',
                  20.0),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: helpIconButton(
                  ColorsApp.primaryColor,
                  BoxShape.circle,
                      () {},
                  Icons.headset_mic_outlined,
                  Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '\$54',
                  style: BodyTextStyle,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'per day',
                  style: BodyTextStyle
                      .copyWith(color: ColorsApp.grayColor),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Sunny Apartment',
              style: BodyTextStyle,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              '1200 / 84K',
              style: BodyTextStyle
                  .copyWith(color: ColorsApp.grayColor),
            ),
          ],
        ),
      ],
    ),
  );
}

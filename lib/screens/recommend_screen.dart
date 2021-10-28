import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';

import 'details_product.dart';

class MobileRecommendedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F8),
      appBar: headerContent(context, 'Recommended'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                List.generate(8, (index) => buildListProduct(context)),
              ),
            ),
            SizedBox(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 15),
                physics: NeverScrollableScrollPhysics(),
                  itemBuilder:  (context,index)=> buildListRecommended(context),
                  separatorBuilder: (context,index)=> Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Divider(color: ColorsApp.grayColor,),
                  ),
                  itemCount: 10
              ),
            )
          ],
        ),
      ),
    );
  }

  buildListRecommended(context)=> GestureDetector(
    onTap: ()
    {
      helpNavigateTo(context, DetailsScreen());
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                helpImage(
                    'https://media-cdn.tripadvisor.com/media/photo-s/1d/91/47/a6/our-double-deluxe-rooms.jpg',
                    10.0),
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
          SizedBox(width: 30,),
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
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/provider/provider.dart';
import 'help.dart';

const kWebWidth = 1392;
const kTabWidth = 800;

class ColorsApp{
  static final primaryColor = Color(0xFF93D8F8);
  static final secColor = Color(0xFFFF9785);
  static final defTextColor = Color(0xFF2F2D51);
  static final col = Color(0xFFF2F7FF);
  static final grayColor = Color(0xFFB9B8CB);
}

//int select = 0;

Widget categoryList(index, context)
{
  var provider = Provider.of<ProviderApp>(context);
  return InkWell(
    onTap: (){
      provider.selectCategory(index);
    },
    child: Container(
      decoration: BoxDecoration(
          color: provider.select == index ? ColorsApp.primaryColor : Colors.transparent,
          border: Border.all(
              color: provider.select == index ? ColorsApp.primaryColor : ColorsApp.grayColor
          )
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons
                  .king_bed_rounded,
              color: provider.select == index
                  ? Colors.white
                  : ColorsApp
                  .defTextColor,
              size: 40,
            ),
            Text(
              'Bed Room',
              style: provider.select == index
                  ? SubtitleTextStyle.copyWith(color: Colors.white)
                  : SubtitleTextStyle.copyWith(color: ColorsApp.defTextColor),
            )
          ],
        ),
      ),
    ),
  );
}

buildListProduct(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: helpContainerShadow(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 290,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                helpImage(
                    'https://media-cdn.tripadvisor.com/media/photo-s/1d/91/47/a6/our-double-deluxe-rooms.jpg',
                    20.0),
                Padding(
                  padding: const EdgeInsets.all(5.0),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
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
                Row(
                  children: [
                    Text(
                      '1200 / 84K',
                      style: BodyTextStyle
                          .copyWith(color: ColorsApp.grayColor),
                    ),
                    SizedBox(
                      width: 120,
                    ),
                    helpIconButton(
                      ColorsApp.secColor,
                      BoxShape.circle,
                          () {},
                      Icons.favorite,
                      Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
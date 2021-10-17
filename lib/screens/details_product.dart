import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/help/animate_button.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.col,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              // convert list to map
                items: [
                  helpImage('https://www.ikea.com/images/sryr-vadheim-munja-d-ma-byadhat-sryr-vitkloever-fy-ghrfh-nwm-18d599765b42ee3396abb67b8a245606.jpg', 0.0),
                  helpImage('https://tanatel.sa/image/cache/catalog/%202%20/%20%D9%88%20%20%D9%83%D9%86%D8%A8/q3%20(2)-500x500.jpg', 0.0),
                ],
                options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: helpContainerShadow(
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sunny Apartment', style: TitleTextStyle,),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Sunny Apartment',
                        style: SubtitleTextStyle,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Wake up to our great bedroom ideas, and you’ll find all the bedroom decor you love, with lots of inspiration for small bedrooms and large bedrooms alike. Whatever your sense of colour and style, we’ll give you something to sleep on. And you’ll sleep better with great décor, so make cosy bedroom decoration your way to a great night’s slumber',
                        style: BodyTextStyle.copyWith(height: 1.5),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Price', style: SubtitleTextStyle,),
                          helpCurrency('200', ColorsApp.primaryColor, 20.0),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          helpButton(
                              width: helpWidth(context) * .35,
                              radius: 10.0,
                              background: ColorsApp.primaryColor,
                              text: 'Buy Now',
                              function: (){},
                          ),
                          SizedBox(width: 10,),
                          helpButton(
                            width: helpWidth(context) * .35,
                            radius: 10.0,
                            background: ColorsApp.col,
                            text: 'Go to AR',
                            function: (){},
                          ),
                        ],
                      ),
                     // SizedBox(height: 30,)
                    ],
                  ),
                )
            ),
          )
        ],
      ),
      floatingActionButton: floatingAnimate(context),
    );
  }
}

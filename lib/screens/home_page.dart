import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/responsive_ui/responsive.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/screens/recommend_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ResponsiveLayout(
            mobileWidget: MobileContent(),
            websiteWidget: WebHomeContent(),
          )),
    );
  }
}

class MobileContent extends StatefulWidget {
  @override
  _MobileContentState createState() => _MobileContentState();
}

class _MobileContentState extends State<MobileContent> {
  int select = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerContent(context, ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find the \nBest Apartment',
                style: TitleTextStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: helpHeight(context) * .07,
                    width: helpWidth(context) * .7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.16),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]
                    ),
                    child: helpTextField(
                      labelText: 'Search Location',
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorsApp.grayColor,
                      ),
                      textInputType: TextInputType.text,
                      radius: 30.0,
                    ),
                  ),
                  helpIconButton(
                    ColorsApp.primaryColor,
                    BoxShape.rectangle,
                    () {},
                    Icons.filter_alt_sharp,
                    Colors.black,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              helpContainerShadow(
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          helpIconButton(
                            ColorsApp.secColor,
                            BoxShape.circle,
                            () {},
                            Icons.home,
                            Colors.white,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Rent Type',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              5, (index) => buildListCategory(context, index)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended',
                      style: SubtitleTextStyle),
                  TextButton(
                    onPressed: ()
                    {
                      helpNavigateTo(context, MobileRecommendedScreen());
                    },
                    child: Text(
                      'See all',
                      style: BodyTextStyle
                          .copyWith(fontSize: 12),
                    ),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      List.generate(
                          5, (index) => buildListProduct(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildListCategory(context, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            select = index;
          });
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    select == index
                        ? BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          )
                        : BoxShadow(
                            color: Colors.white.withOpacity(0),
                            spreadRadius: 0,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          )
                  ]),
              height: 100,
              width: 100,
              child: helpImage(
                  'https://media-cdn.tripadvisor.com/media/photo-s/1d/91/47/a6/our-double-deluxe-rooms.jpg',
                  10.0),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Room',
              style: SubtitleTextStyle.copyWith(
                  color: select == index
                      ? ColorsApp.defTextColor
                      : ColorsApp.grayColor,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class WebHomeContent extends StatelessWidget {
  int select = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderApp>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('RERCA'),
            Text(
              'CASH',
              style: TextStyle(
                  color: ColorsApp.secColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Category'.toUpperCase(),
                    style: BodyTextStyle
                        .copyWith(color: ColorsApp.secColor),
                  )),
              SizedBox(
                width: 50,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Products'.toUpperCase(),
                    style: BodyTextStyle
                        .copyWith(color: ColorsApp.secColor),
                  )),
              SizedBox(
                width: 50,
              ),
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.filter_alt_sharp,
                    color: Colors.black,
                  ),
                  onPressed: () {}),
              SizedBox(
                width: 50,
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              CarouselSlider(
                  // convert list to map
                  items: [
                    helpImage(
                        'https://media-cdn.tripadvisor.com/media/photo-s/1d/91/47/a6/our-double-deluxe-rooms.jpg',
                        0.0),
                    helpImage(
                        'https://media-cdn.tripadvisor.com/media/photo-s/1d/91/47/a6/our-double-deluxe-rooms.jpg',
                        0.0),
                  ],
                  options: CarouselOptions(
                    height: helpHeight(context) * .7,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    autoPlay: true,
                    reverse: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    scrollDirection: Axis.horizontal,
                    enableInfiniteScroll: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                  )),
              Container(
                height: helpHeight(context) * .7,
                width: double.infinity,
                color: Colors.black45,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 80),
                      child: Text(
                        'Find the \nBest Apartment',
                        style: TitleTextStyle.copyWith(color: ColorsApp.primaryColor, fontSize: 40),
                      ),
                    ),
                    Text(
                      'Carefully curated trinkets make your house a\nhome, and express your personality. But it\'s not\njust what you display, it\'s how you display it.',
                      style: SubtitleTextStyle
                          .copyWith(color: ColorsApp.grayColor, height: 2),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    helpButton(
                      text: 'Get Start',
                      width: 200,
                      function: () {
                        //    helpNavigateTo(context, HomePage());
                      },
                      textColor: ColorsApp.defTextColor,
                      radius: 30.0,
                      elevation: 20.0,
                      fontSize: 25.0,
                    ),
                  ],
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'All Product',
                textAlign: TextAlign.center,
                style: TitleTextStyle,
              ),
            ),
            Container(
              // width: helpWidth(context) * .4,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TabBar(
                      labelColor: ColorsApp.secColor,
                      indicatorPadding: EdgeInsets.all(8),
                      indicatorColor: ColorsApp.secColor,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 15),
                      unselectedLabelColor: ColorsApp.primaryColor,
                      tabs: <Widget>[
                        Tab(
                          text: 'Shop by room'.toUpperCase(),
                        ),
                        Tab(
                          text: ' shop by category'.toUpperCase(),
                        ),
                        Tab(
                          text: ' shop by style'.toUpperCase(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: helpHeight(context) - 170,
                      child: TabBarView(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Row(
                            children: [
                              Container(
                                width: helpWidth(context) * .4,
                                height: helpHeight(context) * .6,
                                child: helpImage(
                                    'https://media-cdn.tripadvisor.com/media/photo-s/1d/91/47/a6/our-double-deluxe-rooms.jpg',
                                    20.0),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Container(
                                    width: helpWidth(context) * .4,
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 30.0,
                                      mainAxisSpacing: 30.0,
                                      children:
                                        List.generate(
                                            6, (index) => categoryList(index, context)),
                                      padding: EdgeInsets.zero,
                                      physics: BouncingScrollPhysics(),
                                      childAspectRatio: 28.0 / 10.0,
                                      shrinkWrap: true,
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text('ghxmgrzmg')),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text('ghxmgrzmg')),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Recommended',
                textAlign: TextAlign.center,
                style: TitleTextStyle
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                    List.generate(4, (index) => buildListProduct(context)),
                  ),
                ),
                helpIconButton(
                    ColorsApp.primaryColor,
                    BoxShape.circle,
                        (){},
                    Icons.arrow_forward_ios,
                    Colors.black
                )
              ],
            ),
            SizedBox(height: 50,),
            footerContent(context),
          ],
        ),
      ),
    );
  }
}


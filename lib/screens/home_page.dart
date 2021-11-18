
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled/database/database_method.dart';
import 'package:untitled/help/animate_button.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/responsive_ui/responsive.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/provider/provider_signIn.dart';
import 'package:untitled/screens/recommend_screen.dart';
import 'package:untitled/sharedPrefernce/cache_helper.dart';
import 'drawer/main_drawer.dart';

final CollectionReference refUsers =
FirebaseFirestore.instance.collection('users');
DatabaseMethod databaseMethods = DatabaseMethod();




class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid;
  String photoUrl;
  bool isLoading= true;
  retrieveData() async {
    final userAlreadyLoggedInId = await CacheHelper.checkIfLoggedIn();
    if (userAlreadyLoggedInId != true) {
      BuildContext context;
      await Provider.of<ProviderSignIn>(context, listen: false)
          .definerUser(userAlreadyLoggedInId);
      print('Ok');
    }
  }
  @override
  void didChangeDependencies() async {
    BuildContext context;
    await retrieveData();
    var userProvider = Provider.of<ProviderSignIn>(context, listen: false);
    uid = userProvider.myUser?.uid;
    photoUrl = userProvider.myUser?.photo;
    // await userProvider.getLastMessages(userProvider.myUser!);
    setState(() {
      isLoading = false;
    });

    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: ResponsiveLayout(
        mobileWidget: MobileContent(),
        websiteWidget: WebHomeContent(),
      ),
        floatingActionButton: floatingAnimate(context),
      ),
    );
  }
}

class MobileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children :[
            Stack(
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorsApp.col,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                headerContent(context, ''),
                Positioned(
                  top: 70,
                  left: 10,
                  right: 10,
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ]),
                            child: helpTextField(
                              labelText: 'Search ',
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
                            BoxShape.circle,
                                () {},
                            Icons.filter_alt_sharp,
                            Colors.black,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
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
                        width: 20,
                      ),
                      Text(
                        'Rent Type',
                        style: SubtitleTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: List.generate(
                          5,
                              (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: categoryList(index, context),
                          )
                        //  buildListCategory(context, index)
                      ),
                    ),
                  ),
                  // CategoryScreen()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Collection', style: SubtitleTextStyle),
                TextButton(
                  onPressed: () {
                    helpNavigateTo(context, MobileRecommendedScreen());
                  },
                  child: Text(
                    'See all',
                    style: BodyTextStyle.copyWith(
                        fontSize: 12,
                        color: ColorsApp.primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    5,
                        (index) => buildListCollection(context)
                  //  buildListProduct(context)
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Offers', style: SubtitleTextStyle),
                TextButton(
                  onPressed: () {
                    helpNavigateTo(context, MobileRecommendedScreen());
                  },
                  child: Text(
                    'See all',
                    style: BodyTextStyle.copyWith(
                        fontSize: 12,
                        color: ColorsApp.primaryColor,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                    5,
                        (index) => buildOffersList(context)
                  //  buildListProduct(context)
                ),
              ),
            ),
            ],
          ),
        ),
    );
  }

  buildListCategory(context, index) {
    var provider = Provider.of<ProviderApp>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              provider.selectCategoryHome(index);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    provider.selectHome == index
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
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Room',
            style: SubtitleTextStyle.copyWith(
                color: provider.selectHome == index
                    ? ColorsApp.defTextColor
                    : ColorsApp.grayColor,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class WebHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('ELAN'),
            Text(
              'DALOS',
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
                    style: BodyTextStyle.copyWith(color: ColorsApp.secColor),
                  )),
              SizedBox(
                width: 50,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Products'.toUpperCase(),
                    style: BodyTextStyle.copyWith(color: ColorsApp.secColor),
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
                color: Colors.black12,
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
                        style: TitleTextStyle.copyWith(
                            color: ColorsApp.primaryColor, fontSize: 40),
                      ),
                    ),
                    Text(
                      'Carefully curated trinkets make your house a\nhome, and express your personality. But it\'s not\njust what you display, it\'s how you display it.',
                      style: SubtitleTextStyle.copyWith(
                          color: ColorsApp.grayColor, height: 2),
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
                      labelStyle: BodyTextStyle,
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
                                      children: List.generate(
                                          6,
                                          (index) =>
                                              categoryList(index, context)),
                                      padding: EdgeInsets.zero,
                                      physics: BouncingScrollPhysics(),
                                      childAspectRatio: 28.0 / 10.0,
                                      shrinkWrap: true,
                                    ),
                                  )),
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
              child: Text('Recommended',
                  textAlign: TextAlign.center, style: TitleTextStyle),
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
                helpIconButton(ColorsApp.primaryColor, BoxShape.circle, () {},
                    Icons.arrow_forward_ios, Colors.black)
              ],
            ),
            SizedBox(
              height: 50,
            ),
            footerContent(context),
          ],
        ),
      ),
    );
  }
}

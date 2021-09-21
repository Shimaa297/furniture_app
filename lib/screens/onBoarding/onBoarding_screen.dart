import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/screens/registration/login_screen.dart';

class BoardingModel {
  final String title;
  final String image;
  final String body;
  BoardingModel(
      {@required this.title, @required this.image, @required this.body});
}

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
        title: ' Search Advance Filters',
        image: 'assets/images/search.svg',
        body: 'Discover your property with advance filters like price distance and calender'),
    BoardingModel(
        title: ' Lower prices',
        image: 'assets/images/money.svg',
        body: 'The best models at the lowest prices'),
    BoardingModel(
        title: ' On Boarding Title 3',
        image: 'assets/images/search.svg',
        body: 'Sub Title on boarding title 3'),
  ];

  // void submit()
  // {
  //   CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
  //   {
  //     if(value)
  //     {
  //       navigateTo(context, LoginScreen());
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
          //  onPressed: submit,
            onPressed: ()
            {
              helpNavigateTo(context, HomePage());
            },
            child: Text(
              'SKIP',
              //  textAlign: TextAlign.right,
              style: BodyTextStyle
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            helpIconButton(
              ColorsApp.primaryColor,
              BoxShape.rectangle,
                  (){},
              Icons.single_bed_sharp,
              Colors.white,
            ),
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index)
                {
                  if(index ==boarding.length - 1 )
                  {
                    setState(() {
                      isLast = true;
                    });
                  }else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SmoothPageIndicator(
              controller: boardController,
              count: boarding.length,
              effect: ExpandingDotsEffect(
                dotColor: ColorsApp.grayColor,
                activeDotColor: defaultColor,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 4,
                spacing: 5.0,
              ),
            ),
            SizedBox(height: 20,),
            helpButton(
                text: 'Skip',
                background: ColorsApp.primaryColor,
                fontSize: 20.0,
                width: 180,
                elevation: 20.0,
                radius:50.0,
                function: ()
                {
                  helpNavigateTo(context, LoginScreen());
                }
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 300,
        child: Image.asset(model.image),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        model.title,
        style: TitleTextStyle,
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        model.body,
        textAlign: TextAlign.center,
        style: BodyTextStyle.copyWith(color: ColorsApp.grayColor),
      ),
    ],
  );
}

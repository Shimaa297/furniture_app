import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/screens/registration/login_screen.dart';
import 'package:untitled/sharedPrefernce/cache_helper.dart';

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
        image:
            'https://www.furniturebank.org/wp-content/uploads/Helping-with-Furniture-Logo-300x300.jpg',
        body:
            'Discover your property with advance filters like price distance and calender'),
    BoardingModel(
        title: ' Lower prices',
        image:
            'https://www.furniturebank.org/wp-content/uploads/Helping-with-Furniture-Logo-300x300.jpg',
        body: 'The best models at the lowest prices'),
    BoardingModel(
        title: ' On Boarding Title 3',
        image:
            'https://www.furniturebank.org/wp-content/uploads/Helping-with-Furniture-Logo-300x300.jpg',
        body: 'Sub Title on boarding title 3'),
  ];

 // void skip()
 // {
 //   CacheHelper.saveData(key: 'onBoarding', value: true).then(
 //           (value) {
 //             if(value){
 //               helpNavigateTo(context, LoginScreen());
 //             }
 //           });
 // }
@override
 void didChangeDependencies() async
 {
   final newUser = await CacheHelper.checkIfLoggedIn();
   if( newUser != null){
     helpNavigateTo(context, HomePage());
   }
   super .didChangeDependencies();
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            //  onPressed: submit,
            onPressed: (){},
                //skip(),
            child: Text('SKIP',
                //  textAlign: TextAlign.right,
                style: BodyTextStyle
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            helpIconButton(
              ColorsApp.primaryColor,
              BoxShape.rectangle,
              () {},
              Icons.single_bed_sharp,
              Colors.white,
            ),
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
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
            SizedBox(
              height: 20,
            ),
            helpButton(
                text: 'Continue',
                background: ColorsApp.primaryColor,
                fontSize: 20.0,
                width: 180,
                elevation: 20.0,
                radius: 50.0,
                function: () {
                  helpNavigateTo(context, LoginScreen());
                }),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 250, child: helpImage(model.image, 0.0)),
          SizedBox(
            height: 10,
          ),
          Text(
            model.title,
            style: TitleTextStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model.body,
            textAlign: TextAlign.center,
            style: BodyTextStyle.copyWith(color: ColorsApp.grayColor),
          ),
        ],
      );
}

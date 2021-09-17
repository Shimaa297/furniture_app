// import 'package:flutter/material.dart';
//
// class BoardingModel {
//   final String title;
//   final String image;
//   final String body;
//   BoardingModel(
//       {@required this.title, @required this.image, @required this.body});
// }
//
// class OnBoardScreen extends StatefulWidget {
//   @override
//   _OnBoardScreenState createState() => _OnBoardScreenState();
// }
//
// class _OnBoardScreenState extends State<OnBoardScreen> {
//   var boardController = PageController();
//   bool isLast = false;
//   List<BoardingModel> boarding = [
//     BoardingModel(
//         title: ' On Boarding Title 1',
//         image: 'images/splash.jpg',
//         body: 'Sub Title on boarding title 1'),
//     BoardingModel(
//         title: ' On Boarding Title 2',
//         image: 'images/iconLogin.jpg',
//         body: 'Sub Title on boarding title 2'),
//     BoardingModel(
//         title: ' On Boarding Title 3',
//         image: 'images/splash.jpg',
//         body: 'Sub Title on boarding title 3'),
//   ];
//
//   // void submit()
//   // {
//   //   CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
//   //   {
//   //     if(value)
//   //     {
//   //       navigateTo(context, LoginScreen());
//   //     }
//   //   });
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           TextButton(
//             onPressed: submit,
//             child: Text(
//               'SKIP',
//               //  textAlign: TextAlign.right,
//               style: TextStyle(color: Colors.cyan, fontSize: 18),
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: boardController,
//                 onPageChanged: (int index)
//                 {
//                   if(index ==boarding.length - 1 )
//                   {
//                     setState(() {
//                       isLast = true;
//                     });
//                   }else
//                   {
//                     setState(() {
//                       isLast = false;
//                     });
//                   }
//                 },
//                 physics: BouncingScrollPhysics(),
//                 itemBuilder: (context, index) =>
//                     buildBoardingItem(boarding[index]),
//                 itemCount: boarding.length,
//               ),
//             ),
//             Row(
//               children: [
//                 SmoothPageIndicator(
//                   controller: boardController,
//                   count: boarding.length,
//                   effect: ExpandingDotsEffect(
//                     dotColor: Colors.grey,
//                     activeDotColor: defaultColor,
//                     dotHeight: 10,
//                     dotWidth: 10,
//                     expansionFactor: 4,
//                     spacing: 5.0,
//                   ),
//                 ),
//                 Spacer(),
//                 FloatingActionButton(
//                   onPressed: () {
//                     if(isLast)
//                     {
//                       submit();
//                     }else
//                     {
//                       boardController.nextPage(
//                           duration: Duration(
//                             milliseconds: 750,
//                           ),
//                           curve: Curves.fastLinearToSlowEaseIn);
//                     }
//                   },
//                   child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildBoardingItem(BoardingModel model) => Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Image.asset(model.image),
//       SizedBox(
//         height: 10,
//       ),
//       Text(
//         model.title,
//         style: Theme.of(context).textTheme.bodyText1,
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Text(
//         model.body,
//         style: Theme.of(context).textTheme.subtitle1,
//       ),
//     ],
//   );
// }

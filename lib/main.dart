import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/screens/onBoarding/onBoarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderApp>(
      create: (context) => ProviderApp(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0.0,
          //  textTheme: TextTheme(title: AppBarTextStyle),
          ),
          // textTheme: TextTheme(
          //   subtitle: SubtitleTextStyle,
          //   body1: BodyTextStyle,
          // )
        ),
        home: OnBoardScreen(),
      ),
    );
  }
}



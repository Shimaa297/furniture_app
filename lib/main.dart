import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/screens/home_page.dart';

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
            textTheme: TextTheme(title: AppBarTextStyle),
          ),
          textTheme: TextTheme(
            subtitle: SubtitleTextStyle,
            body1: BodyTextStyle,
          )
        ),
        home: HomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              helpTextField(
                labelText: 'email',
                radius: 20.0,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 30,),
              helpTextField(
                  labelText: 'password',
                  radius: 20.0,
                  textInputType: TextInputType.visiblePassword,
                  isPassword: true,
              ),
              SizedBox(height: 50,),
              helpButton(
                text: 'Login',
                function: ()
                {
                  helpNavigateTo(context, HomePage());
                },
                textColor: ColorsApp.defTextColor,
                radius: 15.0,
                elevation: 20.0,
                fontSize: 25.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/screens/onBoarding/onBoarding_screen.dart';

import 'auth/auth_firebase.dart';
import 'provider/provider_signIn.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
    ChangeNotifierProvider<ProviderApp>(
    create: (context) => ProviderApp()),
    ChangeNotifierProvider<ProviderSignIn>(
    create: (context) => ProviderSignIn()),
    ],
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
        ),
        home: OnBoardScreen(),
      ),
    );
  }
}



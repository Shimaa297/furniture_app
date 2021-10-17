import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/screens/onBoarding/onBoarding_screen.dart';
import 'package:untitled/screens/registration/login_screen.dart';
import 'provider/provider_signIn.dart';
import 'screens/home_page.dart';
import 'sharedPrefernce/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();
  String token = CacheHelper.getData(key: 'token');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  bool isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;

  if(onBoarding != null){
    //if(token != null)
    //  widget = HomePage();
     widget = LoginScreen();
  } else{
    widget = OnBoardScreen();
  }

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;
  MyApp({this.startWidget, this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderApp>(create: (context) => ProviderApp()),
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
            iconTheme: IconThemeData(
              color: ColorsApp.primaryColor,
            ),
            elevation: 0.0,
            //  textTheme: TextTheme(title: AppBarTextStyle),
          ),
        ),
          home: startWidget,
        //  home: HomeAdmin(),
      ),
    );
  }
}

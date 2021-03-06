import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:untitled/auth/auth_firebase.dart';
import 'package:untitled/auth/data/repository_data.dart';
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/provider/provider_signIn.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/screens/profile/profile.dart';
import 'package:untitled/screens/registration/register_screen.dart';
import 'package:untitled/sharedPrefernce/cache_helper.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Auth auth = Auth();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
 bool isLoading = false;

  login(context) async {
    if(_globalKey.currentState.validate())
    {
      // _globalKey.currentState.save();
      setState(() {
        isLoading = true;
        helpLoading();
      });
      var uid = await auth.userLogin(_emailController.text, _passwordController.text);
      //print('Login Done');
      if (uid == null){
        setState(() {
          isLoading = false;
        });
        return helpShowToast('Email or password isn\'t correct');
      } else {
        await CacheHelper().markTheUser(uid);
        UserModel user = await Provider.of<ProviderSignIn>(context, listen: false)
            .definerUser(uid);
        print(user.email);
        helpNavigateTo(context, HomePage());
      }
      // CacheHelper.saveData(key: 'token', value: user.uid).then((value){
      //   helpNavigateTo(context, HomePage());
      // });
      // // helpShowToast('message')
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderApp>(context);
    return Scaffold(
      body: isLoading? helpLoading()
      :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children:[
                Container(
                  height: 300,
                    child: helpImage('https://www.furniturebank.org/wp-content/uploads/Helping-with-Furniture-Logo-300x300.jpg', 0.0)),
                helpTextField(
                  controller: _emailController,
                  labelText: 'email',
                  fillColor: ColorsApp.col,
                  prefixIcon: Icon(
                    Icons.person,
                    color: ColorsApp.primaryColor,
                  ),
                  radius: 50.0,
                  textInputType: TextInputType.emailAddress,
                  validator:(value) {
                    if (value.isEmpty) {
                      return 'Email too Short';
                    } return null;
                  },
                  // onSave: (input)=> _email = input,
                ),
                SizedBox(height: 30,),
                helpTextField(
                  controller: _passwordController,
                  labelText: 'password',
                  isPassword: provider.isPassword,
                  suffixIcon: provider.isPassword ?  Icon(Icons.visibility): Icon(Icons.visibility_off_rounded),
                  suffixPressed: (){provider.isVisibility();},
                  fillColor: ColorsApp.col,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: ColorsApp.primaryColor,
                  ),
                  radius: 50.0,
                  textInputType: TextInputType.visiblePassword,
                  validator:(value) {
                    if (value.isEmpty) {
                      return 'PassWord too Short';
                    } return null;
                  },
                  // onSave: (input)=> _password = input,
                ),
                SizedBox(height: 20,),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:
                        Divider(
                          thickness: 2.0,
                          color: Colors.grey,
                          indent: 20,
                          endIndent: 20,
                        ),
                        width: 150,
                      ),
                      Text('OR', style: BodyTextStyle,),
                      Container(
                        child:
                        Divider(
                          thickness: 2.0,
                          color: Colors.grey,
                          indent: 20,
                          endIndent: 20,
                        ),
                        width: 150,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    helpIconButton(
                        Colors.blue[800],
                        BoxShape.circle,
                            (){
                              AuthRepoImplement authRepoImplement = AuthRepoImplement();
                              authRepoImplement.loginWithFacebook();
                              helpNavigateTo(context, ProfileScreen());
                            },
                        FontAwesome.facebook,
                        Colors.white),
                    helpIconButton(
                        Colors.red,
                        BoxShape.circle,
                            ()
                        {
                          final provider = Provider.of<ProviderSignIn>(context, listen: false);
                          provider.googleLogin();
                          helpNavigateTo(context, ProfileScreen());
                        },
                        FontAwesome.google,
                        Colors.white),
                  ],
                ),
                SizedBox(height: 20,),
                helpButton(
                  text: 'Login',
                  function: ()=>login(context),
                  // function: submitLogin(context),
                  textColor: ColorsApp.defTextColor,
                  radius: 50.0,
                  elevation: 20.0,
                  fontSize: 20.0,
                ),
                //SizedBox(height: 20,),
                TextButton(
                    onPressed: ()
                    {
                      helpNavigateTo(context, RegisterScreen());
                    },
                    child: Text("Register", style: BodyTextStyle,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}

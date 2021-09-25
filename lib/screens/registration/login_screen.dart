import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:untitled/auth/auth_firebase.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/provider/provider_signIn.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/screens/profile/profile.dart';
import 'package:untitled/screens/registration/register_screen.dart';


class LoginScreen extends StatelessWidget {

  Auth auth = Auth();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderApp>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
                            (){},
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
                  function: (){login(context);},
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
                    child: Text("Register", style: SubtitleTextStyle,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login(context) async {
    if(_globalKey.currentState.validate())
    {
      _globalKey.currentState.save();
      await auth.userLogin(_emailController.text, _passwordController.text);
      print('Login Done');
      helpNavigateTo(context, HomePage());
    }
    else{
      auth.showError('Some thing is Error', context);
    }
  }
  //  loginFunction(context) async{
  //   final String email = _emailController.text.trim();
  //   final String password = _passwordController.text.trim();
  //
  //   if(email.isNotEmpty && password.isNotEmpty)
  //   {
  //     if(_globalKey.currentState.validate())
  //     {
  //       await auth.userLogin(email, password);
  //       print('Login Done');
  //       helpNavigateTo(context, HomePage());
  //     }
  //     // await auth.userLogin(email, password);
  //     //     print('Login Done');
  //     //     helpNavigateTo(context, HomePage());
  //     // await auth.userLogin(email, password).then((value)
  //     // {
  //     //   if( != null)
  //     //   {
  //     //     print('Login Done');
  //     //     helpNavigateTo(context, HomePage());
  //     //   } else {
  //     //     auth.showError('error', context);
  //     //   }
  //     // }).catchError((e)=> e.toString());
  //   }
  //   if(email.isEmpty){
  //     print("Email is Empty");
  //   } else{
  //     if(password.isEmpty){
  //       print("Password is Empty");
  //     } else{
  //       auth.userLogin(email, password);
  //       helpNavigateTo(context, HomePage());
  //     }
  //    // helpNavigateTo(context, HomePage());
  //   }
  // }
}

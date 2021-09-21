import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:untitled/auth/auth_firebase.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/screens/home_page.dart';


class LoginScreen extends StatelessWidget {
 Auth auth = Auth();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String _email , _password ;

  submitLogin(context)
  {
    // if(_globalKey.currentState.validate())
    // {
    //   _globalKey.currentState.save();
    // }
      auth.userLogin(email: _email, password: _password);
      helpNavigateTo(context, HomePage());
  }
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
                  labelText: 'email',
                  fillColor: ColorsApp.col,
                  prefixIcon: Icon(
                    Icons.person,
                    color: ColorsApp.primaryColor,
                  ),
                  radius: 50.0,
                  textInputType: TextInputType.emailAddress,
                  validator: (input){
                    if(input == null){
                      Text('Email is Empty');
                    }
                    return null;
                  },
                  onSave: (input)=> _email = input,
                ),
                SizedBox(height: 30,),
                helpTextField(
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
                  validator:(input){
                    if(input==null){
                      Text('Password is Empty');
                    }
                    return null;
                  },
                  onSave: (input)=> _password = input,
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
                            (){},
                        FontAwesome.google,
                        Colors.white),
                  ],
                ),
                SizedBox(height: 20,),
                helpButton(
                  text: 'Login',
                  function: submitLogin(context),
                  textColor: ColorsApp.defTextColor,
                  radius: 50.0,
                  elevation: 20.0,
                  fontSize: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

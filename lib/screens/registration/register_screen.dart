import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


class RegisterScreen extends StatelessWidget {

  Auth auth = Auth();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderApp>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _globalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    helpTextField(
                      controller: _nameController,
                      labelText: 'name',
                      fillColor: ColorsApp.col,
                      prefixIcon: Icon(
                        Icons.person,
                        color: ColorsApp.primaryColor,
                      ),
                      radius: 50.0,
                      textInputType: TextInputType.name,
                      validator: (input){
                        if(input.isEmpty){
                         return 'Name is Empty';
                        }
                        return null;
                      },
                      // onSave: (input)=> _email = input,
                    ),
                    SizedBox(height: 30,),
                    helpTextField(
                      controller: _emailController,
                      labelText: 'email',
                      fillColor: ColorsApp.col,
                      prefixIcon: Icon(
                        Icons.email,
                        color: ColorsApp.primaryColor,
                      ),
                      radius: 50.0,
                      textInputType: TextInputType.emailAddress,
                      validator: (input){
                        if(input.isEmpty){
                          return 'Email is Empty';
                        }
                        return null;
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
                      validator:(input){
                        if(input.isEmpty){
                          return 'Password is Empty';
                        }
                        return null;
                      },
                      // onSave: (input)=> _password = input,
                    ),SizedBox(height: 30,),
                    helpTextField(
                      controller: _phoneController,
                      labelText: 'phone',
                      fillColor: ColorsApp.col,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: ColorsApp.primaryColor,
                      ),
                      radius: 50.0,
                      textInputType: TextInputType.number,
                      validator: (input){
                        if(input.isEmpty){
                         return 'phone is Empty';
                        }
                        return null;
                      },
                      // onSave: (input)=> _email = input,
                    ),
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
                      text: 'Register',
                      function: (){register(context);},
                      // function: submitLogin(context),
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
        ),
      ),
    );
  }
  register(context) async {
    if(_globalKey.currentState.validate())
    {
      _globalKey.currentState.save();
      await auth.userRegister(_emailController.text, _passwordController.text, _nameController.text, _phoneController.text);
      print('Register Done');
      helpNavigateTo(context, HomePage());
    }
    else{
      auth.showError('Some thing is Error', context);
    }
  }
  registerFunction(context) {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();

    if(email.isEmpty){
      print("Email is Empty");
    } else{
      if(password.isEmpty){
        print("Password is Empty");
      } else{
        auth.userRegister(name, phone, email, password);
      }
       helpNavigateTo(context, HomePage());
    }
  }
}

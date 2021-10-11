import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled/auth/auth_firebase.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/help/image_picker_widget.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/provider/provider_signIn.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/screens/profile/profile.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Auth auth = Auth();

  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  // File image;
  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;

  //     // final imageTemporary = File(image.path);
  //     final imageTemporary = await saveImagePermanently(image.path);
  //     setState(() => this.image = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image : $e');
  //   }
  // }

  // Future<File> saveImagePermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');

  //   return File(imagePath).copy(image.path);
  // }

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
                  children: [
                    ImagePickerApp(),
                    // ClipOval(
                    //     child: image != null
                    //         ? ImageWidget(
                    //             image: image,
                    //             onClicked: (source) => pickImage(source))
                    //         // Image.file(image, fit: BoxFit.contain, height: 150, width: 150,) :
                    //         : CircleAvatar(
                    //             backgroundColor: ColorsApp.col,
                    //             radius: 40,
                    //             child: InkWell(
                    //               onTap: () => showModalBottomSheet(
                    //                   context: context,
                    //                   builder: (context) => Column(
                    //                         mainAxisSize: MainAxisSize.min,
                    //                         children: [
                    //                           ListTile(
                    //                             onTap: () =>
                    //                                 Navigator.of(context).pop(
                    //                                     ImageSource.camera),
                    //                             leading: Icon(Icons.camera_alt),
                    //                             title: Text(
                    //                               'Camera',
                    //                               style: BodyTextStyle,
                    //                             ),
                    //                           ),
                    //                           ListTile(
                    //                             onTap: () =>
                    //                                 Navigator.of(context).pop(
                    //                                     ImageSource.gallery),
                    //                             leading: Icon(Icons.photo),
                    //                             title: Text(
                    //                               'Gallery',
                    //                               style: BodyTextStyle,
                    //                             ),
                    //                           )
                    //                         ],
                    //                       )),
                    //               child: Icon(Icons.add_a_photo_outlined),
                    //             ),
                    //           )
                    //     // FlutterLogo(size: 150,)
                    //     // helpImage(
                    //     //     '${user.photoURL}',
                    //     //     200),
                    //     ),
                    SizedBox(
                      height: 20,
                    ),
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
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Name is Empty';
                        }
                        return null;
                      },
                      // onSave: (input)=> _email = input,
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Email is Empty';
                        }
                        return null;
                      },
                      // onSave: (input)=> _email = input,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    helpTextField(
                      controller: _passwordController,
                      labelText: 'password',
                      isPassword: provider.isPassword,
                      suffixIcon: provider.isPassword
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off_rounded),
                      suffixPressed: () {
                        provider.isVisibility();
                      },
                      fillColor: ColorsApp.col,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: ColorsApp.primaryColor,
                      ),
                      radius: 50.0,
                      textInputType: TextInputType.visiblePassword,
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Password is Empty';
                        }
                        return null;
                      },
                      // onSave: (input)=> _password = input,
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                      validator: (input) {
                        if (input.isEmpty) {
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
                            child: Divider(
                              thickness: 2.0,
                              color: Colors.grey,
                              indent: 20,
                              endIndent: 20,
                            ),
                            width: 150,
                          ),
                          Text(
                            'OR',
                            style: BodyTextStyle,
                          ),
                          Container(
                            child: Divider(
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
                        helpIconButton(Colors.blue[800], BoxShape.circle, () {},
                            FontAwesome.facebook, Colors.white),
                        helpIconButton(Colors.red, BoxShape.circle, () {
                          final provider = Provider.of<ProviderSignIn>(context,
                              listen: false);
                          provider.googleLogin();
                          helpNavigateTo(context, ProfileScreen());
                        }, FontAwesome.google, Colors.white),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    helpButton(
                      text: 'Register',
                      function: () {
                        register(context);
                      },
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
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      helpLoading();
      await auth.userRegister(_emailController.text, _passwordController.text,
          _nameController.text, _phoneController.text, image);
      print('Register Done');
      helpNavigateTo(context, HomePage());
    } else {
      auth.showError('Some thing is Error', context);
    }
  }

  registerFunction(context) {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String name = _nameController.text.trim();
    final String phone = _phoneController.text.trim();

    if (email.isEmpty) {
      print("Email is Empty");
    } else {
      if (password.isEmpty) {
        print("Password is Empty");
      } else {
        auth.userRegister(name, phone, email, password, image);
      }
      helpNavigateTo(context, HomePage());
    }
  }
}

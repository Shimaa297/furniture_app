import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:untitled/auth/auth_firebase.dart';
import 'package:untitled/auth/model/user_model.dart';
import 'package:untitled/database/database_method.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/help/image_picker_widget.dart';
import 'package:untitled/provider/provider.dart';
import 'package:untitled/provider/provider_signIn.dart';
import 'package:untitled/screens/home_page.dart';
import 'package:untitled/screens/profile/profile.dart';
import 'package:untitled/sharedPrefernce/cache_helper.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }
  Auth auth = Auth();
  bool isLoading = false;
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();

   File image;
   UserModel userModel;
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
  register(context) async {
    if (_globalKey.currentState.validate()) {
      //_globalKey.currentState.save();
      setState(() {
        isLoading = true;
        helpLoading();
      });
      String uid = await auth.userRegister(
          _email.text, _password.text);
     // print('Register Done');
      if( uid != null){
        Map<String, dynamic> myMap = {
          'email' : _email.text,
          'name' : _name.text,
          'photo' : 'https://firebasestorage.googleapis.com/v0/b/chatappfromscratch.appspot.com/o/user.png?alt=media&token=40743cd8-786f-48cf-bf15-193707d4b1f8',
          'uid' : uid,
          'phone' : _phone.text
        };
        await DatabaseMethod().setUserInfo(uid, myMap);
        await CacheHelper().markTheUser(uid);
        //providerUser//
        Provider.of<ProviderSignIn>(context, listen: false).definerUser(uid);
      }
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)
        {
          return HomePage();
        }
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      auth.showError('Some thing is Error', context);
    }
  }

  getProfileImage() async {
    String photoUrl = image != null
        ? await DatabaseMethod().uploadImageToStorage(image, userModel.uid)
        : '';
    UserModel updatedUser = UserModel(
       // bio: bioController.text,
        photo: image == null ? userModel.photo : photoUrl,
        username: _name.text);
    print('Its the ${updatedUser.email}');
    // User? updatedUser = User(
    //     bio: bioController.text,
    //     photo: myUser!.photo!,
    //     username: usernameController.text);
    Provider.of<ProviderSignIn>(context, listen: false)
        .updateUserInfo(updatedUser, userModel.uid);
  }
  @override

  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderApp>(context);
    return SafeArea(
      child: Scaffold(
        body: isLoading == true ? helpLoading()
       : Padding(
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
                      controller: _name,
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
                      controller: _email,
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
                      controller: _password,
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
                      validator: (password) {
                        if (password.length < 6) {
                          return 'Enter a +6 character password';
                        }
                        return null;
                      },
                      // onSave: (input)=> _password = input,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    helpTextField(
                      controller: _phone,
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



  // registerFunction(context) {
  //   final String email = _emailController.text.trim();
  //   final String password = _passwordController.text.trim();
  //   final String name = _nameController.text.trim();
  //   final String phone = _phoneController.text.trim();
  //
  //   if (email.isEmpty) {
  //     print("Email is Empty");
  //   } else {
  //     if (password.isEmpty) {
  //       print("Password is Empty");
  //     } else {
  //       auth.userRegister(name, phone, email, password, image);
  //     }
  //     helpNavigateTo(context, HomePage());
  //   }
  // }
}
